//
//  MemeModel.swift
//  MemeMe
//
//  Created by Varvara Mironova on 18.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

struct MemeModel {
    var topText      : NSString!
    var bottomText   : NSString!
    var originalImage: UIImage!
    var memedImage   : UIImage!
    
    init(topText:NSString, bottomText:NSString, originalImage:UIImage, memedImage:UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
