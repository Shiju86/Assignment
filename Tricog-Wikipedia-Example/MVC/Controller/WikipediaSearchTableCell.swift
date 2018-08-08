//
//  WikipediaSearchTableCell.swift
//  Tricog-Wikipedia-Example
//
//  Created by Igniva-Ios-Yogesh on 08/08/18.
//  Copyright © 2018 Shiju. All rights reserved.
//

import UIKit
import SDWebImage

class WikipediaSearchTableCell: UITableViewCell {

    @IBOutlet weak var imageVwProfile: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // Mark: Update Cell data
    var searchResultModel: WikipediaModel? {
        didSet{
            setCellData()
        }
    }
    
    func setCellData() {
        if let searchresult = searchResultModel {
            
            imageVwProfile.sd_setShowActivityIndicatorView(true)
            imageVwProfile.sd_setIndicatorStyle(.gray)
            imageVwProfile.sd_setImage(with: URL(string: searchresult.thumbnail ?? ""), placeholderImage: #imageLiteral(resourceName: "nophoto"))
            
            labelTitle.text = searchresult.title
            
            if (searchresult.descriptions.count) > 0 {
                
                if let result: String = searchresult.descriptions[0] {
                    labelDescription.text = result
                }else {
                    blankDescriptionText()
                }
            }else {
                blankDescriptionText()
            }
        }
    }
    
    private func blankDescriptionText() {
        labelDescription.text = "No Description"

    }
}

extension UITableViewCell {
  
  static var identifier: String {
    return String(describing: self)
  }
  
}


