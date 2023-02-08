//
//  NotificationTVC.swift
//  Bio Family
//
//  Created by John on 27/12/22.
//

import UIKit

class NotificationTVC: UITableViewCell {

    
    @IBOutlet weak var lbldate: UILabel!
    
    @IBOutlet weak var lblNotification: UILabel!
    
    
    @IBOutlet weak var notifyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
