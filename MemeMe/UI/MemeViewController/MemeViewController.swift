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
    var topText           : String!
    var bottomText        : String!
    var originalImage     : UIImage!
    var memedImage        : UIImage!

    weak private var rootView: MemeView? {
        return viewIfLoaded as? MemeView
    }
    
    //MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscriptToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscriptToKeyboardNotifications()
    }
    
    //hide keyboard when tap on rootView or any its subview
    override func touchesBegan(_ touches : Set<UITouch>,
                               with event: UIEvent?)
    {
        rootView?.endEditing(true)
        
        super.touchesBegan(touches, with: event)
    }
    
    //MARK: - Interface Handling
    @IBAction func onShareButton(sender: AnyObject) {
        if let rootView = rootView {
            rootView.endEditing(true)
            
            memedImage = generateMemedImage()
            rootView.fillPlaceHolders()
            
            //initialize and show activityViewController
            let activityViewController = UIActivityViewController(activityItems         : [memedImage as Any],
                                                                  applicationActivities : nil)
            activityViewController.completionWithItemsHandler = {[weak self] (activity, success, items, error) in
                guard let strongSelf = self else { return }
                
                if (success) {
                    strongSelf.save()
                    if let tabBarController = strongSelf.storyboard!.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
                    {
                        strongSelf.present(tabBarController,
                                           animated   : true,
                                           completion : nil)
                    }
                } else {
                    strongSelf.dismiss(animated: true, completion: nil)
                }
            }
            
            present(activityViewController, animated: true, completion: nil)
            
        }
}

    @IBAction func onCancelButton(sender: AnyObject) {
        //hide keyboard
        rootView?.endEditing(true)
        
        //initialize and show alert to conform/reject cancel action
        let alert : UIAlertController = UIAlertController(title        : Constants.kCancelAlertTitle,
                                                        message        : Constants.kCancelAlertMessage,
                                                        preferredStyle : .alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "YES",
                                                         style: .default)
        {
            [weak self] (action) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "NO",
                                                        style: .cancel)
        {
            action -> Void in
            //Just dismiss the alert
        }
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func onPhotoButton(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        switch (sender.tag) {
            //takePhoto
        case 1:
            if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                imagePicker.sourceType = .camera
            } else {
                let alert : UIAlertController = UIAlertController(title          : Constants.kCameraAlertTitle,
                                                                  message        : Constants.kCameraAlertMessage,
                                                                  preferredStyle : .alert)
                let cancelAction: UIAlertAction = UIAlertAction(title: "Ok",
                                                                style: .cancel)
                {
                    action -> Void in
                    //Just dismiss the alert
                }
                
                alert.addAction(cancelAction)
                
                present(alert, animated: true, completion: nil)
            }
            
            break
            
            //choose photo in album
        case 2:
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            break
            
        default:
            break
            
        }
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker                          : UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let image = info[.originalImage] as? UIImage,
           let rootView = rootView
        {
            originalImage = image
            rootView.fillWithImage(image: image)
            dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: - UITextFieldDelegate
    func textField(_ textField                    : UITextField,
                   shouldChangeCharactersIn range : NSRange,
                   replacementString string       : String) -> Bool
    {
        // limit characters count in textFields
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        
        return count <= Constants.kMaxTextFieldLength
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    //MARK: - NotificationCenter
    @objc func keyboardWillShow(notification: NSNotification) {
        if (rootView!.isBottomTextFieldEditing()) {
            rootView!.frame.origin.y -= getKeyboardHeight(notification: notification)
        }
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        if (rootView!.isBottomTextFieldEditing()) {
            rootView!.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            return keyboardRectangle.height
        }
        
        return 0.0
    }
    
    func subscriptToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self,
                                               selector : #selector(keyboardWillShow),
                                               name     : UIResponder.keyboardWillShowNotification,
                                               object   : nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector : #selector(keyboardDidShow),
                                               name     : UIResponder.keyboardWillHideNotification,
                                               object   : nil)
    }
    
    func unsubscriptToKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self,
                                                  name   : UIResponder.keyboardWillShowNotification,
                                                  object : nil)
        NotificationCenter.default.removeObserver(self,
                                                  name   : UIResponder.keyboardWillHideNotification,
                                                  object : nil)
    }
    
    //MARK: - Private
    func generateMemedImage() -> UIImage? {
        if let rootView = rootView {
            rootView.clearPlaceHolders()
            
            // Render view to an image
            let contentFrame = rootView.contentView.frame
    
            UIGraphicsBeginImageContext(rootView.frame.size)
            rootView.contentView.drawHierarchy(in                 : contentFrame,
                                               afterScreenUpdates : true)
            if let memedImage = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                
                return memedImage
            }
        }
        
        return nil
    }
    
    func save() {
        //Create the meme
        let meme = MemeModel(topText: topText,
                          bottomText: bottomText,
                       originalImage: originalImage,
                          memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.memes.append(meme)
        }
    }
}
