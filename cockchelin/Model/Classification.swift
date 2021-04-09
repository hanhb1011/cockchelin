//
//  Classification.swift
//  cockchelin
//
//  Created by 한효병 on 2021/04/10.
//

import Foundation

struct Classification: Codable, Identifiable {
    var id = UUID()
    var index: Int
    var name: String
    var ingredientSearchItems: [String] = []
}
