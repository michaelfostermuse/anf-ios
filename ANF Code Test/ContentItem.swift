//
//  ContentItem.swift
//  ANF Code Test
//
//  Created by Michael Muse on 3/1/22.
//

import Foundation

struct ContentItem: Codable {
    let elementType: String?
    let target: String?
    let title: String?
    
    init(target: String?,
         title: String?,
         elementType: String?) {
        self.elementType = elementType
        self.target = target
        self.title = title
    }
}
