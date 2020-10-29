//
//  RandomTextViewModel.swift
//  SwiftUI Demo
//
//  Created by 한효병 on 2020/09/16.
//  Copyright © 2020 hb. All rights reserved.
//

import Foundation
import Combine

struct MyText: Codable {
    var text: String
    var count: Int
}

class ContentViewModel: ObservableObject {
    @Published var myText: MyText = MyText(text: "count value is zero.", count: 0)
    
    func updateText() -> Void {
        
        myText.count += 1
        myText.text = "updated! count: \(myText.count)"
        
        print(myText.text)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(myText) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedText")
        }
    }
    
    init() {
        let defaults = UserDefaults.standard
        if let savedText = defaults.object(forKey: "SavedText") as? Data {
            let decoder = JSONDecoder()
            if let savedText = try? decoder.decode(MyText.self, from: savedText) {
                self.myText = savedText
            }
        }
    }
    
}
