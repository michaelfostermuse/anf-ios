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

enum RouterResult {
    case success(image: UIImage)
    case failure(String)
}

class Router {
    
    let urlString = "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.json"
    
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
    
    func downloadImage(from urlString: String, completion: @escaping (_ result: RouterResult) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure("Invalid URL string."))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                
                else {
                    completion(.failure("Image download config error."))
                    return
                }
       //     DispatchQueue.main.async() { [weak self] in
                
            //let size = self.processImageDimensions(width: image.size.width, height: image.size.height)
            completion(.success(image: image))
        }.resume()
    }
    
   
    
//    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
//
//    func getImage(from urlString: String) {
//        print("Download Started")
//        guard let url = URL(string: urlString) else {
//            return
//        }
//
//        getImageData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
//            // always update the UI from the main thread
//            DispatchQueue.main.async() { [weak self] in
//                //self?.imageView.image = UIImage(data: data)
//            }
//        }
//    }
}
    // initImageApi is called once on app launch and returns a MovieApiConfig object which is then
    // passed in to all network calls requiring an image fetch
//    func initImageApi(completion: @escaping (Result<ExploreDataApiConfig, ANFError>) -> Void) {
//        let urlString = "https://api.themoviedb.org/3/configuration?api_key=\(apiKey)"
//        if let url = URL(string: urlString) {
//            let _: Void = URLSession.shared.dataTask(with: url) {data, _, _ in
//
//                guard let jsonData = data else {
//                    completion(.failure(.noDataAvailable))
//                    return
//                }
//                do {
//                    let decoder = JSONDecoder()
//                    let movieApiConfigResponse = try decoder.decode(ExploreDataApiConfigResponse.self, from: jsonData)
//                    let config = movieApiConfigResponse.images
//                    completion(.success(config))
//                }
//                catch  {
//                    completion(.failure(.noDataAvailable))
//                }
//            }.resume()
//        }
//    }
//}


