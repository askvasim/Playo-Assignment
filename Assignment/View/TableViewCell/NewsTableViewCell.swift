//
//  NewsTableViewCell.swift
//  Assignment
//
//  Created by Vasim Khan on 8/3/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var cellBackgroundView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
