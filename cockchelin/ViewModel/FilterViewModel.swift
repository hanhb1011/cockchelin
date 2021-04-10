//
//  FilterViewModel.swift
//  cockchelin
//
//  Created by 한효병 on 2021/03/14.
//

import Foundation

class FilterViewModel: ObservableObject {
    
    var havingIngredients: [String] = []
    
    /*
     subclass?
     */
    let classificationList: [Classification]
    
    init() {
        classificationList = getClassificationsFromJSONFile()!
        
    }
    
    func getSelectedIngredientList(index: Int) -> String {
        var ret: String = ""
        var i = 0
        classificationList[index].ingredientSearchItems.forEach { ingredient in
            ret.append("[\(i)] \(ingredient)   ")
            i += 1
            if ((i % 2) == 0) {
                ret.append("\n")
            }
        }
        
        return ret
    }
    
    
}
