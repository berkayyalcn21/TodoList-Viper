//
//  TodoTableViewCell.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 31.08.2022.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTodoTitle: UILabel!
    @IBOutlet weak var lblTodoType: UILabel!
    @IBOutlet weak var lblTodoDate: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
