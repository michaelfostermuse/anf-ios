//
//  ExploreDataItemDetailViewController.swift
//  ANF Code Test
//
//  Created by Michael Muse on 2/27/22.
//

import Foundation
import UIKit

class ExploreDataItemDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var contentView: UIStackView!
    var scrollView: UIScrollView!
    var anchorControl: AnyObject!
//    var detailTitle: UILabel!
//    var detailDescription: UILabel!
//    var bottomDescription: UILabel!
//    var promoMessage: UILabel!
    
    private var exploreDataSelectedItem: ExploreDataItem?
    var selectedItem: ExploreDataItem? {
        get {
            return self.exploreDataSelectedItem
        }
        set {
            self.exploreDataSelectedItem = newValue
        }
    }
    
    override func viewDidLayoutSubviews()
      {
       scrollView.delegate = self
       scrollView.contentSize = CGSize(width:self.view.frame.size.width, height: 800) // set height according you
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetView()
        setupScrollView()
        buildImageView()
    }
    
    private func resetView() {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func setupScrollView(){
        scrollView = UIScrollView()
        contentView = UIStackView()
        contentView.axis = .vertical
        
        scrollView.delaysContentTouches = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func buildImageView() {

        let detailImageView = UIImageView()
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(detailImageView)
        detailImageView.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        detailImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        detailImageView.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor).isActive = true

        let router = Router()
        guard let imageUrlString = self.selectedItem?.backgroundImage else { return }
        
        router.downloadImage(from: imageUrlString) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async() { [weak self] in
                    detailImageView.contentMode = .scaleAspectFit
                    detailImageView.image = image
                    // set heightAnchor of imageView according to fetched image aspect ratio
                    let aspectRatio = image.size.height / image.size.width
                    guard let widthAnchor = self?.contentView.safeAreaLayoutGuide.widthAnchor else {
                        return
                    }
                    detailImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: aspectRatio).isActive = true

                    self?.buildViewCopy(imageView: detailImageView)
                    self?.buildContentsList(contents: self?.selectedItem?.content)
                }
            break
               case .failure(let error):
               print(error)
                break;
            }
        }
    }
    
    private func buildViewCopy(imageView: UIImageView) {

        anchorControl = imageView
        if ( self.selectedItem?.topDescription != nil ) {
            let detailDescription = Factory.makeLabel(text: self.selectedItem?.topDescription, fontSize: 13.0)
            contentView.addSubview(detailDescription)
            detailDescription.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            detailDescription.topAnchor.constraint(equalTo: anchorControl.bottomAnchor, constant: 15).isActive = true
            detailDescription.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
            anchorControl = detailDescription
        }
        
        if ( self.selectedItem?.title != nil ) {
            let detailTitle = Factory.makeLabel(text: self.selectedItem?.title, fontSize: 17.0)
            detailTitle.text = self.selectedItem?.title
            contentView.addSubview(detailTitle)
            detailTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            detailTitle.topAnchor.constraint(equalTo: anchorControl.bottomAnchor, constant: 15).isActive = true
            detailTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
            anchorControl = detailTitle
        }
        
        if ( self.selectedItem?.bottomDescription != nil ) {
            lazy var bottomDescriptionButton = Factory.makeButton(buttonText: self.selectedItem?.bottomDescription?.titleText(), fontSize: 11.0)
            bottomDescriptionButton.addTarget(self, action: #selector(self.bottomSescriptionTapped( sender:)),for: .touchUpInside)
            bottomDescriptionButton.tag = 999
            contentView.addSubview(bottomDescriptionButton)
            bottomDescriptionButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            bottomDescriptionButton.topAnchor.constraint(equalTo: anchorControl.bottomAnchor, constant: 10).isActive = true
            bottomDescriptionButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
            anchorControl = bottomDescriptionButton
        }
        
        if ( self.selectedItem?.promoMessage != nil ) {
            let promoMessage = Factory.makeLabel(text: self.selectedItem?.promoMessage, fontSize: 13.0)
            contentView.addSubview(promoMessage)
            promoMessage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            promoMessage.topAnchor.constraint(equalTo: anchorControl.bottomAnchor, constant: 15).isActive = true
            promoMessage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
            anchorControl = promoMessage
        }
    }
    
    private func buildContentsList(contents: [ContentItem]? ) {
        
        guard let contentsArray = contents else {
            return
        }
        var index = 0
        for contentItem in contentsArray {
            lazy var contentButton = Factory.makeButton(buttonText: contentItem.title, fontSize: 15.0)
            contentButton.tag = index
            index += 1
            contentButton.addTarget(self, action: #selector(self.contentButtonTapped( sender:)),for: .touchUpInside)
            
            contentView.addSubview(contentButton)
            contentButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            contentButton.topAnchor.constraint(equalTo: anchorControl.bottomAnchor, constant: 50).isActive = true
            contentButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
            contentButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -400).isActive = true
            anchorControl = contentButton
        }
    }
    
    @objc
    func contentButtonTapped( sender :UIButton)
    {
        guard let urlString = self.selectedItem?.content?[sender.tag].target,
              let url = URL(string: urlString) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc
    func bottomSescriptionTapped( sender: UIButton ) {
        
            guard let urlString = self.selectedItem?.bottomDescription?.urlString(),
                  let url = URL(string: urlString) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
