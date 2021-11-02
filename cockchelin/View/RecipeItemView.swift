//
//  RecipeItemView.swift
//  cockchelin
//
//  Created by 한효병 on 2021/02/13.
//

import SwiftUI

struct RecipeItemView: View {
    let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        NavigationLink(destination: RecipeView(recipe: recipe)){
            HStack{
                Image(RecipeModel.getRandomCocktailImageName())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
                
                VStack(alignment: .leading) {
                    Text(recipe.names[0])
                        .bold()
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 70/255, green: 70/255, blue: 70/255, opacity: 100))
                        .padding(.bottom, 0.5)
                        .lineLimit(1)
                    
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
                    
                }.padding(.leading, 8)
                
                Spacer()
            }
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
        RecipeItemView(recipe: test)
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
