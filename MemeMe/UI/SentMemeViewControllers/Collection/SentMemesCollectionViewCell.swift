//
//  SentMemesCollectionViewCell.swift
//  MemeMe
//
//  Created by Varvara Mironova on 20.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class SentMemesCollectionViewCell: UICollectionViewCell {
    @IBOutlet var memedImageView: UIImageView!
    
    func fillWithModel(model:MemeModel) {
        memedImageView.image = model.memedImage
    }
}
