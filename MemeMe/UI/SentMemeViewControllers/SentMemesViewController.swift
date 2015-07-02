//
//  SentMemesViewController.swift
//  MemeMe
//
//  Created by Varvara Mironova on 20.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class SentMemesViewController: UIViewController {
    var memes        : [MemeModel]!
    var selectedItem : NSInteger!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let delegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = delegate.memes
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let destinationController = segue.destinationViewController as! DetailViewController
        
        destinationController.memeModel = memes[selectedItem]
    }
    
    @IBAction func onCloseButton(sender: AnyObject) {
        presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
}
