//
//  SentMemesViewController.swift
//  MemeMe
//
//  Created by Varvara Mironova on 20.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

// Parent view controller for viewControllers, which display sent memes by table and grid

import UIKit

class SentMemesViewController: UIViewController {
    var memes        : [MemeModel]!
    var selectedItem : NSInteger!
    
    deinit {
        memes = nil
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let delegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = delegate.memes
    }

    @IBAction func onAddMemeButton(sender: AnyObject) {
        let memeViewController = storyboard!.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        
        presentViewController(memeViewController, animated: true, completion: nil)
    }
}
