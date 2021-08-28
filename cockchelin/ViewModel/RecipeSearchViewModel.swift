//
//  RecipeSearchViewModel.swift
//  cockchelin
//
//  Created by 한효병 on 2020/10/31.
//

import Foundation



class RecipeSearchViewModel: ObservableObject {
    
    @Published var recipes: [Recipe]
    
    init(){
        self.recipes = RecipeModel.loadSavedRecipes()
    }
    
    
    
}
