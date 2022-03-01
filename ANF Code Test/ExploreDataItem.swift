//
//  ExploreDataItem.swift
//  ANF Code Test
//
//  Created by Michael Muse on 2/27/22.
//

import Foundation

public struct ExploreDataItem: Decodable {
    let title: String?
    let backgroundImage: String?
    let promoMessage: String?
    let content: [ContentItem]?
    let topDescription: String?
    let bottomDescription: String?
    
    init (title: String?,
          backgroundImage: String?,
          promoMessage: String?,
          content: [ContentItem]?,
          topDescription: String?,
          bottomDescription: String?) {
        
        self.title = title
        self.backgroundImage = backgroundImage
        self.promoMessage = promoMessage
        self.content = content
        self.topDescription = topDescription
        self.bottomDescription = bottomDescription
    }
}
