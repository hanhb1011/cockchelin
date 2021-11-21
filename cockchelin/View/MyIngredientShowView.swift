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
        if (myIngredientShowViewModel.hasNothingToShow()) {
            CenterTextView(text: "가진 재료가 등록되지 않았습니다.\n가진 재료를 등록해주세요.")
                .navigationBarTitle(Text("만들 수 있는 칵테일"))
        }
        else {
            ScrollView(.vertical){
                HStack {Spacer()}
                VStack {
                    ForEach(myIngredientShowViewModel.recipes.filter {
                        return myIngredientShowViewModel.isMakeableRecipe(recipe: $0)
                    }.sorted(by: { recipe0, recipe1 in
                        recipe0.names[0] < recipe1.names[0]
                    })
                    ){section in
                        RecipeItemView(recipe: section)
                    }
                    
                    ForEach(myIngredientShowViewModel.recipes.filter {
                        return myIngredientShowViewModel.isConditionallyMakeableRecipe(recipe: $0, diff: 1)
                    }.sorted(by: { recipe0, recipe1 in
                        recipe0.names[0] < recipe1.names[0]
                    })
                    ){section in
                        RecipeItemView(recipe: section, additionalTitle: "재료 1개 부족")
                    }
                    
                    ForEach(myIngredientShowViewModel.recipes.filter {
                        return myIngredientShowViewModel.isConditionallyMakeableRecipe(recipe: $0, diff: 2)
                    }.sorted(by: { recipe0, recipe1 in
                        recipe0.names[0] < recipe1.names[0]
                    })
                    ){section in
                        RecipeItemView(recipe: section, additionalTitle: "재료 2개 부족")
                    }
                    
                    Spacer()
                }
            }
            .navigationBarTitle(Text("만들 수 있는 칵테일"))
            .padding(.horizontal, 15)
            .background(Color.themeBackground.edgesIgnoringSafeArea(.all))
            .onAppear {
                myIngredientShowViewModel.refresh()
            }
        }
        
    }
}

struct MyIngredientShowView_Previews: PreviewProvider {
    static var previews: some View {
        MyIngredientShowView()
    }
}
