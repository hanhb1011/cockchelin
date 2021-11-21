//
//  MyIngredientViewModel.swift
//  cockchelin
//
//  Created by 한효병 on 2021/11/02.
//

import Foundation

class MyIngredientAddViewModel: ObservableObject {
    
    @Published var classificationList: [Classification]
    
    init() {
        classificationList = loadClassifications()!
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
        
        saveClassificationsToUserDefaults(classifications: newClassificationList)
    }
    
}
