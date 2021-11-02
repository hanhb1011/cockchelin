//
//  HomeViewModel.swift
//  cockchelin
//
//  Created by 한효병 on 2021/09/04.
//

import Foundation

enum PhraseType: Codable {
    
    case summer
    case spring
    case fall
    case winter
    case simpleRecipe
    case green
    case red
    case peach
    case coconut
    case sweet
    case soft
    case sour
    case night0
    case night1
    case weekend
    case beautiful
    case mixedColor
    case tequila
    case whisky
    case rum
    case gin
    case vodka
    case colorful0
    case colorful1
    case light
    case normal
    case strong
    case tired
    
}

class HomeViewModel: ObservableObject {
    @Published var recipes: [Recipe]
    @Published var classificationList: [Classification]
    
    init(){
        self.recipes = RecipeModel.loadSavedRecipes()
        self.classificationList = loadClassifications()!
    }
    
    func refresh() {
        self.recipes = RecipeModel.loadSavedRecipes()
        self.classificationList = loadClassifications()!
    }
    
    static func getLastVisitedDateFromUserDefaults() -> Date? {
        let defaults = UserDefaults.standard
        if let lastVisitedDate = defaults.object(forKey: "LastVisitedDate") as? Data {
            let decoder = JSONDecoder()
            if let lastVisitedDate = try? decoder.decode(Date.self, from: lastVisitedDate) {
                return lastVisitedDate
            }
        }
        
        return nil
    }
    
    static func getTodaysRecipeFromUserDefaults() -> Recipe? {
        let defaults = UserDefaults.standard
        if let savedRecipe = defaults.object(forKey: "TodaysRecipe") as? Data {
            let decoder = JSONDecoder()
            if let savedRecipe = try? decoder.decode(Recipe.self, from: savedRecipe) {
                return savedRecipe
            }
        }
        
        return nil
    }
    
    static func getPhraseTypeFromUserDefaults() -> PhraseType? {
        let defaults = UserDefaults.standard
        if let phraseType = defaults.object(forKey: "PhraseType") as? Data {
            let decoder = JSONDecoder()
            if let phraseType = try? decoder.decode(PhraseType.self, from: phraseType) {
                return phraseType
            }
        }
        
        return nil
    }
    
    func recipePhraseUnitTest() -> Void {
        recipes.shuffled()[0..<20].forEach { recipe in
            pickPhraseType(recipe: recipe, currentDate: Date())
        }
    }
    
    func isIngredientContained(recipe: Recipe, ingredient: String) -> Bool {
        var found = false
        
        recipe.ingredients.forEach {
            $0.names.forEach { name in
                if(name.contains(ingredient)) {
                    found = true
                }
            }
        }
        
        return found
    }
    
    func pickPhraseType(recipe: Recipe, currentDate: Date) -> PhraseType {
        var candidates: [PhraseType] = []
        
        let weekday = Calendar.current.component(.weekday, from: currentDate)
        if (1 == weekday || 7 == weekday) {
            candidates.append(.weekend)
        }
        
        let month = Calendar.current.component(.month, from: currentDate)
        if ((1 <= month && month <= 2) || (12 == month)) {
            candidates.append(.winter)
        }
        else if (3 <= month && month <= 5) {
            candidates.append(.spring)
        }
        else if (6 <= month && month <= 9) {
            candidates.append(.summer)
        }
        else {
            candidates.append(.fall)
        }
        
        let ingredientsCount = recipe.ingredients.count
        if (ingredientsCount == 2) {
            candidates.append(.simpleRecipe)
        }
        
        if (recipe.liquidColor == .green) {
            candidates.append(.green)
        }
        
        if (recipe.liquidColor == .red) {
            candidates.append(.green)
        }
        
        if (true == isIngredientContained(recipe: recipe, ingredient: "피치 리큐어")) {
            candidates.append(.peach)
        }
        
        if (true == isIngredientContained(recipe: recipe, ingredient: "코코넛")) {
            candidates.append(.coconut)
        }
        
        if (isIngredientContained(recipe: recipe, ingredient: "레몬 주스") || isIngredientContained(recipe: recipe, ingredient: "라임 주스") || isIngredientContained(recipe: recipe, ingredient: "오렌지 리큐어")) {
            candidates.append(.sour)
        }
        
        if (isIngredientContained(recipe: recipe, ingredient: "계란 흰자") || isIngredientContained(recipe: recipe, ingredient: "크림") || isIngredientContained(recipe: recipe, ingredient: "우유")) {
            candidates.append(.soft)
        }
        
        let hour  = Calendar.current.component(.hour, from: currentDate)
        if (18 <= hour) {
            candidates.append(.night0)
            candidates.append(.night1)
        }
        
        if (recipe.liquidColor == .red || recipe.liquidColor == .blue || recipe.liquidColor == .green) {
            candidates.append(.beautiful)
            candidates.append(.colorful0)
            candidates.append(.colorful1)
        }
        else if (recipe.liquidColor == .mixed) {
            candidates.append(.mixedColor)
        }
        
        if (isIngredientContained(recipe: recipe, ingredient: "데킬라") && recipe.ingredients.count <= 3) {
            candidates.append(.tequila)
        }
        
        if (isIngredientContained(recipe: recipe, ingredient: "위스키") && recipe.ingredients.count <= 3) {
            candidates.append(.whisky)
        }
        
        if (isIngredientContained(recipe: recipe, ingredient: "럼") && recipe.ingredients.count <= 3) {
            candidates.append(.rum)
        }
        
        if (isIngredientContained(recipe: recipe, ingredient: "진") && recipe.ingredients.count <= 3) {
            candidates.append(.gin)
        }
        
        if (isIngredientContained(recipe: recipe, ingredient: "보드카") && recipe.ingredients.count <= 3) {
            candidates.append(.vodka)
        }
        
        let alcoholDegree = recipe.alcoholDegree
        if (alcoholDegree <= 10) {
            candidates.append(.light)
        }
        else if (alcoholDegree <= 20) {
            candidates.append(.normal)
        }
        else {
            candidates.append(.strong)
        }
        
        candidates.append(.tired)
        
        return candidates.randomElement()!
    }
    
    func updateTodaysRecipe(recipe: Recipe) -> Void {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(recipe) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "TodaysRecipe")
        }
        
        //update last visited date
        let currentDate = Date()
        if let encoded = try? encoder.encode(currentDate) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "LastVisitedDate")
        }
        
        let phraseType = pickPhraseType(recipe: recipe, currentDate: currentDate)
        if let encoded = try? encoder.encode(phraseType) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "PhraseType")
        }
    }
    
    func getTodaysCocktail() -> Recipe {
        var recipe: Recipe? = nil
        var phraseType: PhraseType? = nil
        var isUpdateNeeded: Bool = false
        
        //get today's date
        let currentDate = Date()
        
        //get last visited date
        let lastVisitedDate = HomeViewModel.getLastVisitedDateFromUserDefaults()
        
        if (lastVisitedDate == nil) {
            isUpdateNeeded = true
        }
        else if (Calendar.current.compare(lastVisitedDate!, to: currentDate, toGranularity: .day).rawValue != 0){
            isUpdateNeeded = true
        }
        else {
            recipe = HomeViewModel.getTodaysRecipeFromUserDefaults()
            if (recipe == nil) {
                isUpdateNeeded = true
            }
            
            phraseType = HomeViewModel.getPhraseTypeFromUserDefaults()
            if (phraseType == nil) {
                isUpdateNeeded = true
            }
        }
        
        if (isUpdateNeeded == true) {
            recipe = recipes.randomElement()
            updateTodaysRecipe(recipe: recipe!)
        }
        
        return recipe!
    }
    
    func isMakeableRecipe(recipe: Recipe, ingredients: [String], minDiff: Int) -> Bool {
        var missCount = 0
        
        recipe.ingredients.forEach { ingredient in
            let ingredientInRecipe: String = ingredient.names[0]
            var found = false
            
            ingredients.forEach { givenIngredient in
                if (ingredientInRecipe == givenIngredient) {
                    found = true
                }
            }
            
            if (false == found) {
                missCount += 1
            }
        }
        
        if (missCount <= minDiff) {
            return true
        }
        else {
            return false
        }
    }
    
    func getMakebaleRecipes(recipeCount: Int) -> [Recipe] {
        var makeableRecipes: [Recipe] = []
        let ingredients: [String] = getIngredientsFromClassificationList()
        makeableRecipes = recipes.filter { isMakeableRecipe(recipe: $0, ingredients: ingredients, minDiff: 1) }
        
        makeableRecipes.shuffle()
        
        if (recipeCount < makeableRecipes.count) {
            makeableRecipes.removeSubrange(recipeCount..<makeableRecipes.count)
        }
        
        return makeableRecipes
    }
    
    func getFavoriteRecipes(recipeCount: Int) -> [Recipe] {
        var favoriteRecipes: [Recipe] = recipes.filter { $0.favoriteChecked == true }
        
        favoriteRecipes.shuffle()
        
        if (recipeCount < favoriteRecipes.count) {
            favoriteRecipes.removeSubrange(recipeCount..<favoriteRecipes.count)
        }
        
        return favoriteRecipes
    }
    
    func combine(_ left: [Recipe], _ right: [Recipe]) -> [Recipe] {
        var candidates: [Recipe] = left + right
        var duplicateIndice: [Int] = []
        
        for i in (0..<candidates.count) {
            var isDuplicated = false
            for j in (i+1..<candidates.count) {
                if (candidates[i].id == candidates[j].id) {
                    isDuplicated = true
                }
            }
            
            if (isDuplicated == true) {
                duplicateIndice.append(i)
            }
        }
        
        duplicateIndice.sorted().reversed().forEach { i in
            candidates.remove(at: i)
        }
        
        return candidates
    }
    
    func getCocktailsForYou(maxCount: Int) -> [Recipe] {
        /*
         1. select makeable recipes.
         2. select recipes that were in the bookmark list.
         3. select random recipes.
         4. shuffle and return.
         */
        let makeableCocktails = getMakebaleRecipes(recipeCount: 7)
        let favoriteCocktails = getFavoriteRecipes(recipeCount: 3)
        
        var candidates: [Recipe] = combine(makeableCocktails, favoriteCocktails)
        var recipeCount = candidates.count
        
        while (recipeCount < maxCount) {
            let randomElement = recipes.randomElement()!
            var isDuplicated = false
            candidates.forEach { recipe in
                if (recipe.names[0] == randomElement.names[0]) {
                    isDuplicated = true
                }
            }
            if (isDuplicated == false) {
                candidates.append(randomElement)
                recipeCount += 1
            }
        }
        
        return candidates
    }
    
    func getRecentlyViewedCocktails(maxCount: Int) -> [Recipe] {
        let recentlyViewedCocktails: [Recipe] = recipes
            .filter {$0.lastTimeRecipeOpened != nil}
            .sorted { $0.lastTimeRecipeOpened! > $1.lastTimeRecipeOpened!}
        
        let adjustedMax = recentlyViewedCocktails.count < maxCount ? recentlyViewedCocktails.count : maxCount
        
        return Array(recentlyViewedCocktails[0..<adjustedMax])
    }
    
    
    
    static func getRecipeInstructionPhrase() -> String {
        let recipe: Recipe = getTodaysRecipeFromUserDefaults()!
        let phraseType: PhraseType = getPhraseTypeFromUserDefaults()!
        
        switch(phraseType) {
        case .summer:
            return "더운 여름을 시원하게 날려줄 \(recipe.names[0]) 한 잔 어때요?"
        case .spring:
            return  "따스한 봄에 어울리는 \(recipe.names[0]) 한 잔 어때요?"
        case .fall:
            return "선선한 날, 가을에 어울리는 \(recipe.names[0]) 한 잔 어때요?"
        case .winter:
            return "추운 겨울에 즐길 수 있는 \(recipe.names[0]) 한 잔 어때요?"
        case .simpleRecipe:
            return "가볍게 만들 수 있는 \(recipe.names[0]) 한 잔 어때요?"
        case .green:
            return "싱그러운 \(recipe.names[0]) 한 잔 어떄요?"
        case .red:
            return "강렬한 색깔의 \(recipe.names[0]) 한 잔 어때요?"
        case .peach:
            return "달콤한 복숭아 향 가득! \(recipe.names[0]) 한 잔 어때요?"
        case .coconut:
            return "달콤한 복숭아 향 가득! \(recipe.names[0]) 한 잔 어때요?"
        case .sweet:
            return "달달한 \(recipe.names[0]) 한 잔 어떄요?"
        case .soft:
            return "부드러움의 끝판왕, \(recipe.names[0]) 한 잔 어때요?"
        case .sour:
            return "침샘 자극하는 \(recipe.names[0]) 한 잔 어때요?"
        case .night0:
            return "지친 당신을 위로해줄 \(recipe.names[0]) 한 잔 어때요?"
        case .night1:
            return "고된 하루를 마무리 지어줄 \(recipe.names[0]) 한 잔 어때요?"
        case .weekend:
            return "여유로운 주말에 즐기는 \(recipe.names[0]) 한 잔 어때요?"
        case .beautiful:
            return "갬성 가득, 예쁜 \(recipe.names[0]) 한 잔 어때요?"
        case .mixedColor:
            return "알록달록 예쁜 \(recipe.names[0]) 한 잔 어때요?"
        case .tequila:
            return "데킬라 하나로 만들 수 있는 \(recipe.names[0]) 한 잔 어때요?"
        case .whisky:
            return "위스키 하나로 만들 수 있는 \(recipe.names[0]) 한 잔 어떄요?"
        case .rum:
            return "럼 하나로 만들 수 있는 \(recipe.names[0]) 한 잔 어떄요?"
        case .gin:
            return "진 하나로 만들 수 있는 \(recipe.names[0]) 한 잔 어떄요?"
        case .vodka:
            return "보드카 하나로 만들 수 있는 \(recipe.names[0]) 한 잔 어떄요?"
        case .colorful0:
            return "독특한 색깔의 \(recipe.names[0]) 한 잔 어때요?"
        case .colorful1:
            return "보는 재미가 가득! \(recipe.names[0]) 한 잔 어떄요?"
        case .light:
            return "알쓰를 위한 \(recipe.names[0]) 한 잔 어떄요?"
        case .normal:
            return "적당한 도수의 \(recipe.names[0]) 한 잔 어떄요?"
        case .strong:
            return "한 잔으로 취해버리고 싶다면? \(recipe.names[0]) 한 잔 어때요?"
        case .tired:
            return "지친 마음, \(recipe.names[0]) 한 잔으로 쓸어내리는 건 어때요?"
        }
        
        
    }
    
}
