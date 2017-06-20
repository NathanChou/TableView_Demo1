//
//  MyCell.swift
//  FirstDemo
//
//  Created by 周彥宏 on 2017/3/14.
//  Copyright © 2017年 周彥宏. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func didTransition(to state: UITableViewCellStateMask){
        self.textField.isEnabled = state.contains(.showingEditControlMask);
        if self.textField.isEnabled == true{
            self.textField.borderStyle = .roundedRect;
        }else{
            self.textField.borderStyle = .none;
        }
        super.didTransition(to: state);
        
    }


}
