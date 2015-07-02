//
//  DetailView.swift
//  MemeMe
//
//  Created by Varvara Mironova on 02.07.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class DetailView: UIView {
    @IBOutlet var backButton    : UIButton!
    @IBOutlet var memedImageView: UIImageView!
    
    func fillWithModel(model:MemeModel) {
        memedImageView.image = model.memedImage
    }

}
