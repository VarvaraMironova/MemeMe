//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Varvara Mironova on 15.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate,
                                            UINavigationControllerDelegate,
                                            UITextFieldDelegate
{
    var memeModel         : MemeModel!
    var topText           : NSString!
    var bottomText        : NSString!
    var originalImage     : UIImage!
    var memedImage        : UIImage!

    @IBOutlet var rootView: MemeView?
    
    deinit {
        unsubscriptToKeyboardNotifications()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        subscriptToKeyboardNotifications()
        
        clearMeme()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        rootView!.endEditing(true)
    }
    
    @IBAction func onShareButton(sender: AnyObject) {
        rootView!.endEditing(true)
        
        memedImage = generateMemedImage()
        
        rootView!.fillPlaceHolders()
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {activity, success, items, error in
            self.save()
            self.dismissViewControllerAnimated(true, completion: nil)
            let tabBarController = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
            self.presentViewController(tabBarController, animated: true, completion: nil)
        }
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
}

    @IBAction func onCancelButton(sender: AnyObject) {
        rootView!.endEditing(true)
        
        let alert : UIAlertController = UIAlertController(title: Constants.cancelAlertTitle,
                                                        message: Constants.cancelAlertMessage,
                                                 preferredStyle: .Alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "YES", style: .Default) {action -> Void in
            self.clearMeme()
            
            self.rootView!.clearAll()
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "NO", style: .Cancel) {action -> Void in
            //Just dismiss the alert
        }
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func onPhotoButton(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        switch (sender.tag) {
            //takePhoto
        case 1:
            if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
                imagePicker.sourceType = .Camera
            } else {
                let alert : UIAlertController = UIAlertController(title: Constants.cameraAlertTitle,
                                                                  message: Constants.cameraAlertMessage,
                                                                  preferredStyle: .Alert)
                let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Cancel) {action -> Void in
                    //Just dismiss the alert
                }
                
                alert.addAction(cancelAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
            break
            
            //choose photo in album
        case 2:
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            break
            
        default:
            break
            
        }
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        originalImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        rootView!.fillWithImage(originalImage)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (range.length + range.location > count(textField.text.utf16)) {
            return false
        }
        
        return count(textField.text.utf16) + count(string.utf16) - range.length <= Constants.maxTextFieldLength
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        switch (textField.tag) {
            //topTextField
        case 1:
            topText = textField.text
            break
            
            //bottomTextField
        case 2:
            bottomText = textField.text
            break
            
        default:
            break
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func keyboardWillShow(notification:NSNotification) {
        if (rootView!.isBottomTextFieldEditing()) {
            rootView!.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardDidShow(notification:NSNotification) {
        if (rootView!.isBottomTextFieldEditing()) {
            rootView!.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification:NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.CGRectValue().height
    }
    
    func subscriptToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillShow:",
                                                         name: UIKeyboardWillShowNotification,
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardDidShow:",
                                                         name: UIKeyboardWillHideNotification,
                                                         object: nil)
    }
    
    func unsubscriptToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func generateMemedImage() -> UIImage {
        rootView!.clearPlaceHolders()
        
        // Render view to an image
        let contentFrame = rootView!.contentView.frame
        
        UIGraphicsBeginImageContext(contentFrame.size)
        rootView!.contentView.drawViewHierarchyInRect(contentFrame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    func save() {
        //Create the meme
        var meme = MemeModel(topText: self.topText,
                          bottomText: self.bottomText,
                               image: self.originalImage,
                          memedImage: self.memedImage)
        
        // Add it to the memes array in the Application Delegate
        let delegate = (UIApplication.sharedApplication().delegate as! AppDelegate)

        delegate.memes.append(meme)
    }
    
    func clearMeme() {
        memedImage = nil
        originalImage = nil
        topText = ""
        bottomText = ""
    }
}
