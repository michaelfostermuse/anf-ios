//
//  ContentItem.swift
//  ANF Code Test
//
//  Created by Michael Muse on 3/1/22.
//

import Foundation

struct ContentItem: Codable {
    let target: String?
    let title: String?
    
    init(target: String?,
         title: String?) {
        self.target = target
        self.title = title
    }
}
