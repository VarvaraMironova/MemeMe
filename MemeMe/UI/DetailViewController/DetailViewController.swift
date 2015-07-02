//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Varvara Mironova on 02.07.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var memeModel         : MemeModel!
    
    @IBOutlet var rootView: DetailView!

    @IBAction func onBackButton(sender: AnyObject) {
        presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (memeModel != nil) {
            rootView!.fillWithModel(memeModel)
        }
    }

}
