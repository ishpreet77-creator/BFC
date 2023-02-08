//
//  HistoryTVC.swift
//  Bio Family
//
//  Created by John on 05/01/23.
//

import UIKit

class HistoryTVC: UITableViewCell {
    @IBOutlet weak var Lblinsurance: UILabel!
    
    @IBOutlet weak var LblReason: UILabel!
    
    @IBOutlet weak var LblDate: UILabel!

    @IBOutlet weak var lblReaseon: UILabel!
    @IBOutlet weak var mainview: UIViewX!
    
    @IBOutlet weak var LabelView: UIViewX!
    
    @IBOutlet weak var historyImageView: UIImageView!
    @IBOutlet weak var dateTopConstant : NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
