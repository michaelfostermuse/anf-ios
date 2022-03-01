//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {

    var exploreDataApiConfig: ExploreDataApiConfig?

    private lazy var exploreData = [ExploreDataItem]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        let router = Router()
        router.getExploreData() { [weak self] result in
            switch result {
            
            case .failure(let error):
                print(error)
            
            case .success(let exploreData):
                self?.exploreData = exploreData
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exploreData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExploreContentCell", for: indexPath)
        if let titleLabel = cell.viewWithTag(1) as? UILabel,
           let titleText = exploreData[indexPath.row].title {
            titleLabel.text = titleText
        }

        if let imageView = cell.viewWithTag(2) as? UIImageView,
           let backgroundImageUrl = exploreData[indexPath.row].backgroundImage {
//           let image = UIImage(named: name) {
//            imageView.image = image
        }
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if let titleText = exploreData?[indexPath.row]["title"] as? String,
//        let imageName = exploreData?[indexPath.row]["backgroundImage"] as? String,
//        let promoMessage = exploreData?[indexPath.row]["promoMessage"] as? String,
//        let topDescription = exploreData?[indexPath.row]["topDescription"] as? String,
//        let bottomDescription = exploreData?[indexPath.row]["bottomDescription"] as? String {
//            let selectedItem = ExploreDataItem(title: titleText,
//                                               backgroundImageUrl: imageName,
//                                               promoMessage: promoMessage,
//                                               content: [],
//                                               topDescription: topDescription,
//                                               bottomDescription: bottomDescription)
//
//            self.selectedItem = selectedItem
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "explore-data-item-selected-segue" {
            navigationController?.setNavigationBarHidden(false, animated: true)
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
              //  self.selectedItem = self.exploreData?[indexPath.row]
//            let promoMessage = exploreData?[indexPath.row]["promoMessage"] as? String
//            let topDescription = exploreData?[indexPath.row]["topDescription"] as? String
//            let bottomDescription = exploreData?[indexPath.row]["bottomDescription"] as? String
                
            let selectedItem =  self.exploreData[indexPath.row]
                
                let controller = segue.destination as! ExploreDataItemDetailViewController
                controller.selectedItem = selectedItem
            }
        }
    }
}
