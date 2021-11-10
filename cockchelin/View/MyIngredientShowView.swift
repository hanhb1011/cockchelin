//
//  MyIngredientShowView.swift
//  cockchelin
//
//  Created by 한효병 on 2021/11/02.
//

import SwiftUI

struct MyIngredientShowView: View {
    var myIngredientShowViewModel: MyIngredientShowViewModel = MyIngredientShowViewModel()
    
    
    var body: some View {
        
        ScrollView(.vertical){
            VStack {
                /* Filter */
                ForEach(myIngredientShowViewModel.recipes.filter {
                    return myIngredientShowViewModel.isMakeableRecipe(recipe: $0)
                }.sorted(by: { recipe0, recipe1 in
                    recipe0.names[0] < recipe1.names[0]
                })
                ){section in
                    RecipeItemView(recipe: section)
                    .background(Color.white)
                    .cornerRadius(15)
                }
                
                ForEach(myIngredientShowViewModel.recipes.filter {
                    return myIngredientShowViewModel.isConditionallyMakeableRecipe(recipe: $0, diff: 1)
                }.sorted(by: { recipe0, recipe1 in
                    recipe0.names[0] < recipe1.names[0]
                })
                ){section in
                    RecipeItemView(recipe: section)
                    .background(Color.white)
                    .cornerRadius(15)
                }
                
                ForEach(myIngredientShowViewModel.recipes.filter {
                    return myIngredientShowViewModel.isConditionallyMakeableRecipe(recipe: $0, diff: 2)
                }.sorted(by: { recipe0, recipe1 in
                    recipe0.names[0] < recipe1.names[0]
                })
                ){section in
                    RecipeItemView(recipe: section)
                    .background(Color.white)
                    .cornerRadius(15)
                }
                
                Spacer()
            }
        }
        .background(Color.themeBackground.edgesIgnoringSafeArea(.all))
        .onAppear {
            myIngredientShowViewModel.refresh()
        }
        
    }
}

struct MyIngredientShowView_Previews: PreviewProvider {
    static var previews: some View {
        MyIngredientShowView()
    }
}
