//
//  Filter.swift
//  cockchelin
//
//  Created by 한효병 on 2021/01/03.
//

import Foundation


class Filter: ObservableObject {
    
    @Published var minDegree: Double = 0.0
    @Published var maxDegree: Double = 100.0
    
    @Published var ingredients: [String] = []
    
    init() {
        
    }
    
}
