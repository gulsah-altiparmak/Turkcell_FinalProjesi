//
//  CustomCell.swift
//  Turkcell_FinalProjesi
//
//  Created by Gulsah Altiparmak on 31.01.2021.
//

import UIKit

class CustomCell: UITableViewCell {

   
   
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderProductName: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var orderPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}





