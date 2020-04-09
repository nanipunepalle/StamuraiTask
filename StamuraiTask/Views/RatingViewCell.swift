//
//  RatingViewCell.swift
//  StamuraiTask
//
//  Created by Lalith on 09/04/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import UIKit

class RatingViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        for i in 1...stackView.subviews.count{
            stackView.removeArrangedSubview(stackView.viewWithTag(i)!)
            stackView.viewWithTag(i)?.removeFromSuperview()
            
        }
    }
    
}
