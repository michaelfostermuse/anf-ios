//
//  UIImageView+Ext.swift
//  ANF Code Test
//
//  Created by Michael Muse on 3/1/22.
//

import Foundation
import UIKit


extension UIImageView {
    private func downloadImage(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                
                else { return }
            DispatchQueue.main.async() { [weak self] in
                
                self?.frame.size = CGSize(width: image.size.width, height: image.size.height)
                self?.image = image
                
                self?.adjustSize(ratio: image.size.width / image.size.height)
            }
        }.resume()
    }
    
    private func adjustSize(ratio: CGFloat) {
        if self.frame.width > self.frame.height {
            let newHeight = self.frame.width / ratio
            self.frame.size = CGSize(width: self.frame.width, height: newHeight)
        }
        else{
            let newWidth = self.frame.height * ratio
            self.frame.size = CGSize(width: newWidth, height: self.frame.height)
        }
    }
    
    func downloadImage(from imageUrlString: String?, contentMode mode: ContentMode = .scaleAspectFit) {
        
        guard let urlString = imageUrlString,
              let url = URL(string: urlString)
        else {
            return
        }
        downloadImage(from: url, contentMode: mode)
    }
}
