//
//  MemeModel.swift
//  MemeMe
//
//  Created by Varvara Mironova on 18.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class MemeModel: NSObject {
    var topText     : NSString!
    var bottomText  : NSString!
    var originalImage: UIImage!
    var memedImage  : UIImage!
    
    deinit {
        topText = nil
        bottomText = nil
        originalImage = nil
        memedImage = nil
    }
    
    init(topText:NSString, bottomText:NSString, image:UIImage, memedImage:UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = image
        self.memedImage = memedImage
    }
}
