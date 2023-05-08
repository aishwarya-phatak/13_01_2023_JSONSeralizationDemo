//
//  AlbumTableViewCell.swift
//  13_01_2023_JSONSeralizationDemo
//
//  Created by Vishal Jagtap on 05/05/23.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var userIdlabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
