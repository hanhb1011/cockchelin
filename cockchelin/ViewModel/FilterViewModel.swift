//
//  FilterViewModel.swift
//  cockchelin
//
//  Created by 한효병 on 2021/03/14.
//

import Foundation

class FilterViewModel: ObservableObject {
    
    /*
     subclass?
     */
    @Published var classificationList: [Classification]
    
    init() {
        classificationList = getClassificationsFromJSONFile()!
        
    }
    
    func toggleSelectedVariable(id: UUID, classificationIdx: Int) {
        
        let updatedIngredientSearchItems = classificationList[classificationIdx].ingredientSearchItems.map { searchItem -> IngredientSearchItem in
            if (searchItem.id == id) {
                var modifiedSearchIdem = searchItem
                modifiedSearchIdem.selected.toggle()
                return modifiedSearchIdem
            }
            else {
                return searchItem
            }
        }
        
        let newClassificationList = classificationList.map { classification -> Classification in
            if (classification.index == classificationIdx) {
                var modifiedClassification = classification
                modifiedClassification.ingredientSearchItems = updatedIngredientSearchItems
                return modifiedClassification
            }
            
            return classification
        }
        
        classificationList = newClassificationList
        
        //TODO update in UserDefaults
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
