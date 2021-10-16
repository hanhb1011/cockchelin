//
//  RecipeView.swift
//  SwiftUI Demo
//
//  Created by 한효병 on 2020/09/30.
//  Copyright © 2020 hb. All rights reserved.
//

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe
    @ObservedObject var recipeViewModel: RecipeViewModel
    
    @State private var numberSelectorIndex = 0
    @State private var numbers: [Int] = [1, 2, 3, 4]
    
    @State private var unitSelectorIndex = RecipeViewModel.getSelectedUnitIndex()
    @State private var units: [LiquidUnitType] = [.ml, .oz]
    
    var body: some View {
        ScrollView() {
            VStack {
                Image("temp")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250, alignment: .center)
                
                HStack {
                    Spacer()
                    HStack {
                        Image(systemName: "flame")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28, alignment: .center)
                            .foregroundColor(Color(red: 255/255, green: 100/255, blue: 168/255, opacity: 100))
                        
                        Text("\(recipeViewModel.recipe.alcoholDegree) %")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color(red: 135/255, green: 135/255, blue: 135/255, opacity: 100))
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "number")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(Color(red: 255/255, green: 100/255, blue: 168/255, opacity: 100))
                        
                        Text("\(recipeViewModel.recipe.ingredients.count) 개의 재료")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color(red: 135/255, green: 135/255, blue: 135/255, opacity: 100))
                    }
                    Spacer()
                    
                    HStack {
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28, alignment: .center)
                            .foregroundColor(Color(red: 255/255, green: 100/255, blue: 168/255, opacity: 100))
                        
                        Text(recipeViewModel.getTechniqueTypes())
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color(red: 135/255, green: 135/255, blue: 135/255, opacity: 100))
                    }
                    Spacer()
                }
                .padding(.horizontal, 30)
                /*
                 Text("(\(recipe.alcoholDegree) %)")
                 Text(recipeViewModel.recipe.lastTimeRecipeOpened.description).foregroundColor(.gray)
                 */
                
                HStack {
                    Text("수량")
                        .bold()
                        .font(.system(size: 20, weight: .bold))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                    Spacer()
                    Picker("Numbers", selection: $numberSelectorIndex) {
                        ForEach(0 ..< numbers.count) { index in
                            Text(String(self.numbers[index])).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .fixedSize()
                    .padding(.horizontal, 30)
                    .padding(.vertical, 5)
                }
                
                HStack {
                    Text("재료")
                        .bold()
                        .font(.system(size: 20, weight: .bold))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                    Spacer()
                    Picker("Units", selection: $unitSelectorIndex) {
                        ForEach(0 ..< units.count) { index in
                            Text(self.units[index].rawValue).tag(index)
                        }
                    }
                    .onChange(of: unitSelectorIndex, perform: { value in
                        RecipeViewModel.updateSelectedUnitIndex(selectedUnitIndex: unitSelectorIndex)
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    .fixedSize()
                    .padding(.horizontal, 30)
                    .padding(.vertical, 5)
                }
                ForEach(recipeViewModel.recipe.ingredients) { ingredient in
                    HStack {
                        Image(systemName: "checkmark.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(Color(red: 255/255, green: 100/255, blue: 168/255, opacity: 100))
                            .padding(.horizontal, 5)
                        Text("\(ingredient.names[0])")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                        if (ingredient.type != .none) {
                            Text(String(self.recipeViewModel.getLiquidVolume(ingredient: ingredient, liquidUnitType: self.units[unitSelectorIndex], numberOfServings: self.numbers[numberSelectorIndex])))
                                .font(.system(size: 16))
                                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                        }
                        
                        if (ingredient.type == .oz || ingredient.type == .ml) {
                            Text(self.units[unitSelectorIndex].rawValue)
                                .font(.system(size: 16))
                                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                        }
                        else if (ingredient.type != .none) {
                            Text(ingredient.type.rawValue)
                                .font(.system(size: 16))
                                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 2)
                }
                
                if (recipe.garnish != nil) {
                    HStack {
                        Text("가니쉬")
                            .bold()
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "checkmark.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(Color(red: 255/255, green: 100/255, blue: 168/255, opacity: 100))
                            .padding(.horizontal, 5)
                        
                        Text(recipeViewModel.getGarnishString())
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 2)
                    
                }
                HStack {
                    Text("레시피")
                        .bold()
                        .font(.system(size: 20, weight: .bold))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                    Spacer()
                }
                
                ForEach(0..<recipeViewModel.recipe.RecipeInformation.count) { i in
                    
                    HStack {
                        Image(systemName: recipeViewModel.getIndexImage(index: i))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(Color(red: 255/255, green: 100/255, blue: 168/255, opacity: 100))
                            .padding(.horizontal, 5)
                        
                        Text(recipeViewModel.getRecipeProcessString(recipeProcess: recipeViewModel.recipe.RecipeInformation[i]))
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 2)
                }
                
            }
        }
        .navigationBarTitle(Text(recipeViewModel.recipe.names[0]))
        .background(Color.themeBackground.edgesIgnoringSafeArea(.all))
        .navigationBarItems(trailing:
                                Button(action: {
            recipeViewModel.checkFavorite()
        }) {
            if (true == recipeViewModel.recipe.favoriteChecked) {
                Image(systemName: "star.fill")
                    .foregroundColor(Color(red: 255/255, green: 100/255, blue: 168/255, opacity: 100))
            }
            else {
                Image(systemName: "star")
                    .foregroundColor(Color(red: 255/255, green: 100/255, blue: 168/255, opacity: 100))
            }
        }
        )
        .onAppear {
            recipeViewModel.updateCurrentTimestamp()
        }
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe //TODO change parameter type to UUID
        self.recipeViewModel = RecipeViewModel(recipe: recipe)
        
    }
}

#if DEBUG
let testRecipe = Recipe(names: ["Recipe name"],
                        alcoholDegree: 25,
                        ingredients: [Ingredient(names: ["ingredient0"], volume: 60, type: .ml), Ingredient(names: ["ingredient1"], volume: 1, type: .oz)],
                        favoriteChecked: false,
                        RecipeInformation: [RecipeProcess(ingredientIndex: 0, behavior: .pour)],
                        techniqueTypes: [.build],
                        lastTimeRecipeOpened: Date(),
                        latitude: 0.0, longitude: 1.1,
                        liquidColor: .blue,
                        glassType: .stemmedLiqueurGlass,
                        garnish: "가니쉬")
#endif

struct RecipeView_Previews: PreviewProvider {
    
    static var previews: some View {
        RecipeView(recipe: testRecipe)
    }
}
