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
    var filter: Filter
    
    init(filter: Filter) {
        self.filter = filter
    }
}
