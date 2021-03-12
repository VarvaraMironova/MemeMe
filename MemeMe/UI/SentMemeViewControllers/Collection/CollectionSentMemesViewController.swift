//
//  CollectionSentMemesViewController.swift
//  MemeMe
//
//  Created by Varvara Mironova on 20.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class CollectionSentMemesViewController: SentMemesViewController,
                                         UICollectionViewDataSource,
                                         UICollectionViewDelegate
{
    
    weak private var rootView: CollectionSentMemesRootView? {
        return viewIfLoaded as? CollectionSentMemesRootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let rootView = rootView {
            rootView.memesCollectionView.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView               : UICollectionView,
                        numberOfItemsInSection section : Int) -> Int
    {
        return memes?.count ?? 0
    }
    
    func collectionView(_ collectionView        : UICollectionView,
                        cellForItemAt indexPath : IndexPath) -> UICollectionViewCell
    {
        let cellID = "SentMemesCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID,
                                                         for: indexPath) as! SentMemesCollectionViewCell
        if let memes = memes
        {
            cell.fillWithModel(model: memes[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView          : UICollectionView,
                        didSelectItemAt indexPath : IndexPath)
    {
        if let memes = memes {
            showDetails(meme: memes[indexPath.row])
        }
    }

}
