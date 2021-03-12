//
//  SentMemesTableViewCell.swift
//  MemeMe
//
//  Created by Varvara Mironova on 20.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {
    @IBOutlet var memedImageView : UIImageView!
    @IBOutlet var bottomLabel    : UILabel!
    @IBOutlet var topLabel       : UILabel!
    
    func fillWithModel(model:MemeModel) {
        memedImageView.image = model.memedImage
        
        bottomLabel.text = model.bottomText
        topLabel.text = model.topText
    }
}
