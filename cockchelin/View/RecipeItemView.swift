//
//  RecipeItemView.swift
//  cockchelin
//
//  Created by 한효병 on 2021/02/13.
//

import SwiftUI

struct RecipeItemView: View {
    let recipe: Recipe
    let additionalTitle: String?
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.additionalTitle = nil
    }
    
    init(recipe: Recipe, additionalTitle: String) {
        self.recipe = recipe
        self.additionalTitle = additionalTitle
    }
    
    var body: some View {
        NavigationLink(destination: RecipeView(recipe: recipe)){
            HStack{
                Image(RecipeModel.getCocktailImageName(recipe: recipe))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
                    .padding(.horizontal, 1)
                    .padding(.vertical, 5)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .bottom) {
                        Text(recipe.names[0])
                            .bold()
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(red: 70/255, green: 70/255, blue: 70/255, opacity: 100))
                            .padding(.bottom, 0.5)
                        .lineLimit(1)
                        
                        if (additionalTitle != nil) {
                            Text(additionalTitle!)
                                .font(.system(size: 13))
                                .foregroundColor(Color(red: 200/255, green: 150/255, blue: 150/255, opacity: 100))
                        }
                    }
                    
                    HStack {
                        Text(getIngredient())
                            .font(.system(size: 13))
                            .foregroundColor(Color(red: 150/255, green: 150/255, blue: 150/255, opacity: 100))
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Text("\(recipe.alcoholDegree)%")
                        .font(.system(size: 13))
                        .foregroundColor(Color(red: 150/255, green: 150/255, blue: 150/255, opacity: 100))
                    
                }
                
                Spacer()
            }
            .background(Color.white)
            .cornerRadius(15)
        }
        
    }
    
    func getIngredient() -> String {
        var ret: String = ""
        
        self.recipe.ingredients.forEach { ingredient in
            ret.append("\(ingredient.names[0])  ")
        }
        
        return ret;
    }
}

struct RecipeItemView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeItemView(recipe: test,additionalTitle: "재료 1개 부족")
    }
}

#if DEBUG
let test = Recipe(names: ["Recipe name"],
                  alcoholDegree: 25,
                  ingredients: [Ingredient(names: ["ingredient0"], volume: 60, type: .ml), Ingredient(names: ["ingredient1"], volume: 1, type: .oz), Ingredient(names: ["ingredient2"], volume: 1, type: .oz), Ingredient(names: ["ingredient3"], volume: 1, type: .oz)],
                  favoriteChecked: false,
                  RecipeInformation: [RecipeProcess(ingredientIndex: 0, behavior: .pour)],
                  techniqueTypes: [.build],
                  lastTimeRecipeOpened: Date(),
                  latitude: 0.0, longitude: 1.1,
                  liquidColor: .blue,
                  glassType: .stemmedLiqueurGlass)
#endif
