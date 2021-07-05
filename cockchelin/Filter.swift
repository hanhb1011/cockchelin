//
//  Filter.swift
//  cockchelin
//
//  Created by 한효병 on 2021/01/03.
//

import Foundation


class Filter: ObservableObject {
    @Published var minDegree: Double = 0.0
    @Published var maxDegree: Double = 50.0
    
    @Published var isEnabled: Bool = false
    @Published var ingredients: [String] = []
    
    init() {
        
    }
    
    func updateIngredients(ingredients: [String]) {
        
        self.ingredients = ingredients
        
        print(ingredients)
    }
}
