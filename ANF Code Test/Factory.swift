//
//  Factory.swift
//  ANF Code Test
//
//  Created by Michael Muse on 3/5/22.
//

import Foundation
import UIKit

struct Factory {
    
    static func makeLabel(text: String?, fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        
        return label
    }
    
    static func makeButton( buttonText: String?, fontSize: CGFloat ) -> UIButton {
        let button = UIButton()
        button.setTitle(buttonText, for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}
