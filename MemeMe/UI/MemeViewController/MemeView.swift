//
//  MemeView.swift
//  MemeMe
//
//  Created by Varvara Mironova on 15.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class MemeView: UIView {
    @IBOutlet var bottomTextField : UITextField!
    @IBOutlet var topTextField    : UITextField!
    @IBOutlet var headerView      : UIToolbar!
    @IBOutlet var cancelButton    : UIBarButtonItem!
    @IBOutlet var shareButton     : UIBarButtonItem!
    @IBOutlet var memeImageView   : UIImageView!
    @IBOutlet var bottomView      : UIView!
    @IBOutlet var albumButton     : UIButton!
    @IBOutlet var takePhotoButton : UIButton!
    @IBOutlet var contentView     : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fillPlaceHolders()
        
        UITextField.appearance().tintColor = UIColor(red: 83.0/255.0, green: 166.0/255.0, blue: 124.0/255.0, alpha: 1.0)
        
        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
        
        enableShareButton(false)
    }
    
    func enableShareButton(enable:Bool) {
        shareButton.enabled = enable
    }
    
    func fillWithImage(image:UIImage) {
        memeImageView.image = image
        
        enableShareButton(true)
    }
    
    func clearPlaceHolders() {
        topTextField.placeholder = ""
        bottomTextField.placeholder = ""
    }
    
    func fillPlaceHolders() {
        topTextField.placeholder = Constants.kTopPlaceHolder
        bottomTextField.placeholder = Constants.kBottomPlaceHolder
    }
    
    func isBottomTextFieldEditing() -> Bool {
        var result : Bool = false
        
        if (bottomTextField.isFirstResponder()) {
            result = true
        }
        
        return result
    }
}
