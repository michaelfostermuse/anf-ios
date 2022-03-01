//
//  ExploreDataConfig.swift
//  ANF Code Test
//
//  Created by Michael Muse on 2/28/22.
//

import Foundation

struct ExploreDataApiConfigResponse:Decodable {
    var images:ExploreDataApiConfig
}

struct ExploreDataApiConfig: Decodable {
    let base_url: String?
    let secure_base_url: String?
}
