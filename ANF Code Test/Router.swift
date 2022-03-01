//
//  Router.swift
//  ANF Code Test
//
//  Created by Michael Muse on 2/27/22.
//

import Foundation
import UIKit

enum ANFError:Error {
    case noDataAvailable
}

class Router {
    
    let apiKey = "5885c445eab51c7004916b9c0313e2d3"
    let urlString = "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.json"
   // var movieApiConfig: MovieApiConfig?
    
    // SearchViewController passes this in upon initialization
//    func initNetwork(config: MovieApiConfig?) {
//        movieApiConfig = config
//    }
    
    // getExploreData is the main search call called on every search term change
    func getExploreData(completion: @escaping (Result<[ExploreDataItem], ANFError>) -> Void) {
        
        if let url = URL(string: urlString) {
            let _: Void = URLSession.shared.dataTask(with: url) {data, _, _ in
                
                guard let jsonData = data else {
                    completion(.failure(.noDataAvailable))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    
//                    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
//                            petitions = jsonPetitions.results
//                            tableView.reloadData()
//                        }
                    
                    
                    let dataResponse = try decoder.decode([ExploreDataItem].self, from: jsonData)
                    let exploreData = dataResponse
                    completion(.success(exploreData))
                }
                catch  {
                    print(error)
                    completion(.failure(.noDataAvailable))
                }
            }.resume()
        }
    }
    
    // initImageApi is called once on app launch and returns a MovieApiConfig object which is then
    // passed in to all network calls requiring an image fetch
    func initImageApi(completion: @escaping (Result<ExploreDataApiConfig, ANFError>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/configuration?api_key=\(apiKey)"
        if let url = URL(string: urlString) {
            let _: Void = URLSession.shared.dataTask(with: url) {data, _, _ in
                
                guard let jsonData = data else {
                    completion(.failure(.noDataAvailable))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let movieApiConfigResponse = try decoder.decode(ExploreDataApiConfigResponse.self, from: jsonData)
                    let config = movieApiConfigResponse.images
                    completion(.success(config))
                }
                catch  {
                    completion(.failure(.noDataAvailable))
                }
            }.resume()
        }
    }
}


