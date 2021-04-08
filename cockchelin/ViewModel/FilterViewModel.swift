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
    let classificationList: [Classification] = [Classification(index: 0, name: "기주"), Classification(index: 1, name: "리큐어"), Classification(index: 2, name: "주스"), Classification(index: 3, name: "기타")]
    
    
    
    
    
    
}

struct Classification: Identifiable {
    var id = UUID()
    var index: Int
    var name: String
    var ingredientSearchItems: [IngredientSearchItem] = []
}

struct IngredientSearchItem {
    let ingredientName: String
    let imageName: String
}
