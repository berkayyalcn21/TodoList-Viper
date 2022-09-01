//
//  homeTableViewCell.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 27.08.2022.
//

import UIKit

class homeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
