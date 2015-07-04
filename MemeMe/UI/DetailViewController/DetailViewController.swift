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
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        hidesBottomBarWhenPushed = true
    }

    @IBAction func onBackButton(sender: AnyObject) {
        navigationController!.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (memeModel != nil) {
            rootView!.fillWithModel(memeModel)
        }
    }

}
