//
//  ExploreDataItemDetailViewController.swift
//  ANF Code Test
//
//  Created by Michael Muse on 2/27/22.
//

import Foundation
import UIKit

class ExploreDataItemDetailViewController: UIViewController {
    
    private var exploreDataSelectedItem: ExploreDataItem?
    var selectedItem: ExploreDataItem? {
        get {
            return self.exploreDataSelectedItem
        }
        set {
            self.exploreDataSelectedItem = newValue
        }
    }
}
