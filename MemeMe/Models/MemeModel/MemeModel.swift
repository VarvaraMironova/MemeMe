//
//  MemeModel.swift
//  MemeMe
//
//  Created by Varvara Mironova on 18.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

struct MemeModel {
    var topText    : String?
    var bottomText : String?
    
    var originalImage : UIImage!
    var memedImage    : UIImage!
    
    init(topText       : String? = "",
         bottomText    : String? = "",
         originalImage : UIImage,
         memedImage    : UIImage)
    {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
