//
//  Item.swift
//  cockchelin
//
//  Created by Hyojin Choi on 2021/01/01.
//

import SwiftUI

struct Item : Identifiable{
    var id = UUID().uuidString
    var name : String
    var details : String
    var image : String
    var price : Float
}
