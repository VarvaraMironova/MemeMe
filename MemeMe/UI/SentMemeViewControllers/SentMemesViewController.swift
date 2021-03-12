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
    var memes        : [MemeModel]?
    var selectedItem : NSInteger?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get and save [MemeModel]
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            memes = delegate.memes
        }
    }
    
    func showDetails(meme: MemeModel) {
        if let destinationController = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        {
            destinationController.memeModel = meme
            navigationController?.pushViewController(destinationController,
                                                     animated: true)
        }
    }
}
