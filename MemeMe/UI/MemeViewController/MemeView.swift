//
//  MemeView.swift
//  MemeMe
//
//  Created by Varvara Mironova on 15.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class MemeView: UIView {
    @IBOutlet var bottomTextField   : UITextField!
    @IBOutlet var topTextField      : UITextField!
    @IBOutlet var cancelButton      : UIButton!
    @IBOutlet var shareButton       : UIButton!
    @IBOutlet var headerView        : UIView!
    @IBOutlet var memeImageView     : UIImageView!
    @IBOutlet var bottomView        : UIView!
    @IBOutlet var albumButton       : UIButton!
    @IBOutlet var takePhotoButton   : UIButton!
    @IBOutlet var contentView       : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fillPlaceHolders()
        
        enableShareButton(false)
    }
    
    func enableShareButton(enable:Bool) {
        self.shareButton.enabled = enable
    }
    
    func fillWithImage(image:UIImage) {
        memeImageView.image = image
        
        enableShareButton(true)
        
        self.layoutIfNeeded()
    }
    
    func clearAll() {
        memeImageView.image = nil
        topTextField.text = ""
        bottomTextField.text = ""
        
        fillPlaceHolders()
        
        enableShareButton(false)
    }
    
    func clearPlaceHolders() {
        topTextField.placeholder = ""
        bottomTextField.placeholder = ""
    }
    
    func fillPlaceHolders() {
        topTextField.placeholder = Constants.topPlaceHolder
        bottomTextField.placeholder = Constants.bottomPlaceHolder
    }
    
    func isBottomTextFieldEditing() -> Bool {
        var result : Bool = false
        
        if (bottomTextField.isFirstResponder()) {
            result = true
        }
        
        return result
    }
}
