//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Varvara Mironova on 15.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

//  Controller for editing meme

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
    }
    
    //hide keyboard when tap on rootView or any its subview
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        rootView!.endEditing(true)
    }
    
    @IBAction func onShareButton(sender: AnyObject) {
        //hide keyboard
        rootView!.endEditing(true)
        
        memedImage = generateMemedImage()
        
        rootView!.fillPlaceHolders()
        
        //initialize and show activityViewController
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {activity, success, items, error in
            if (success) {
                self.save()
                
                let tabBarController = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
                self.presentViewController(tabBarController, animated: true, completion: nil)
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        presentViewController(activityViewController, animated: true, completion: nil)
}

    @IBAction func onCancelButton(sender: AnyObject) {
        //hide keyboard
        rootView!.endEditing(true)
        
        //initialize and show alert to conform/reject cancel action
        let alert : UIAlertController = UIAlertController(title: Constants.kCancelAlertTitle,
                                                        message: Constants.kCancelAlertMessage,
                                                 preferredStyle: .Alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "YES", style: .Default) {action -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "NO", style: .Cancel) {action -> Void in
            //Just dismiss the alert
        }
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
        
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
                let alert : UIAlertController = UIAlertController(title: Constants.kCameraAlertTitle,
                                                                  message: Constants.kCameraAlertMessage,
                                                                  preferredStyle: .Alert)
                let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Cancel) {action -> Void in
                    //Just dismiss the alert
                }
                
                alert.addAction(cancelAction)
                
                presentViewController(alert, animated: true, completion: nil)
            }
            
            break
            
            //choose photo in album
        case 2:
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            break
            
        default:
            break
            
        }
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        originalImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        rootView!.fillWithImage(originalImage)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func                textField(textField: UITextField,
        shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool
    {
        // limit characters count in textFields
        if (range.length + range.location > count(textField.text.utf16)) {
            return false
        }
        
        return count(textField.text.utf16) + count(string.utf16) - range.length <= Constants.kMaxTextFieldLength
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
            rootView!.frame.origin.y = 0
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
        
        UIGraphicsBeginImageContext(rootView!.frame.size)
        rootView!.contentView.drawViewHierarchyInRect(contentFrame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    func save() {
        //Create the meme
        let topMemeText = topText == nil ? "" : topText
        let bottomMemeText = bottomText == nil ? "" : bottomText
        var meme = MemeModel(topText: topMemeText,
                          bottomText: bottomMemeText,
                       originalImage: originalImage,
                          memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        let delegate = (UIApplication.sharedApplication().delegate as! AppDelegate)

        delegate.memes.append(meme)
    }
}
