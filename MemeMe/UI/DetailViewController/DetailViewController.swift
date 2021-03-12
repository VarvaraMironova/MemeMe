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
    
    weak private var rootView: DetailView? {
        return viewIfLoaded as? DetailView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidesBottomBarWhenPushed = true
        
        if let memeModel = memeModel,
           let rootView = rootView
        {
            rootView.fillWithModel(model: memeModel)
        }
    }

    @IBAction func onBackButton(sender: AnyObject) {
        navigationController?.popToRootViewController(animated: true)
    }

}
