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
    @IBOutlet var rootView: MemeView?
    
    deinit {
        unsubscriptToKeyboardNotifications()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        subscriptToKeyboardNotifications()
    }
    
    @IBAction func onShareButton(sender: AnyObject) {
        
    }

    @IBAction func onCancelButton(sender: AnyObject) {
        
    }
    
    @IBAction func onPhotoButton(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        switch (sender.tag) {
            //takePhoto
        case 1:
            if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
                imagePicker.sourceType = .Camera
            } else {
                let alert : UIAlertController = UIAlertController(title: "Sory =(",
                                                                  message: "Camere is not available",
                                                                  preferredStyle: .Alert)
                let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Cancel) {action -> Void in
                    //Just dismiss the action sheet
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
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func keyboardWillShow(notification:NSNotification) {
        rootView!.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardDidShow(notification:NSNotification) {
        rootView!.frame.origin.y += getKeyboardHeight(notification)
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
}
