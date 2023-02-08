//
//  Models.swift
//  BestKetone
//
//  Created by John on 28/05/21.
//

import Foundation

class ReadingFilters{
    var days: Int = 0
    var filterString: String = ""
    var isSelected: Bool = false
    
    init(days: Int = 0, filterString: String = "", isSelected: Bool = false) {
        self.days = days
        self.filterString = filterString
        self.isSelected = isSelected
    }
}
