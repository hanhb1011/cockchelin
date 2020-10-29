//
//  Recipe.swift
//  SwiftUI Demo
//
//  Created by 한효병 on 2020/09/26.
//  Copyright © 2020 hb. All rights reserved.
//

import Foundation


struct Recipe: Codable, Identifiable {
    var id = UUID()
    var name: String
    let alcoholDegree: Int
    var ingredients: [Ingredient]
    var favoriteChecked: Bool
    var RecipeInformation: String
    let techniqueType: TechniqueType
    var lastTimeRecipeOpened: Date
    let latitude: Double
    let longitude: Double
    let liquidColor: LiquidColorType
    let glassType: String
}

struct Ingredient: Codable, Identifiable {
    var id = UUID()
    var name: String
    var volume: Double
    var type: LiquidUnitType
    
    internal init(name: String, volume: Double, type: LiquidUnitType) {
        self.name = name
        self.volume = volume
        self.type = type
    }
}

enum TechniqueType: String, Codable {
    case build
    case stir
    case shake
}

enum LiquidColorType: String, Codable {
    case red
    case blue
}

enum LiquidUnitType: String, Codable {
    case ml
    case oz
    case dash
    case part
    case tsp
}
