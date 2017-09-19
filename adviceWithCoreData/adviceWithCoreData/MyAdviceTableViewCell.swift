//
//  MyAdviceTableViewCell.swift
//  adviceWithCoreData
//
//  Created by Тарас Евченко on 19.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import UIKit

class MyAdviceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myAdviceCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
