//
//  CollectionSentMemesViewController.swift
//  MemeMe
//
//  Created by Varvara Mironova on 20.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class CollectionSentMemesViewController: SentMemesViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var rootView: CollectionSentMemesRootView!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let selectedCell = sender as! SentMemesCollectionViewCell
        selectedItem = rootView.memesCollectionView.indexPathForCell(selectedCell)!.row
        
        super.prepareForSegue(segue, sender: sender)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemesCollectionViewCell", forIndexPath: indexPath) as! SentMemesCollectionViewCell
        cell.fillWithModel(memes[indexPath.row])
        
        return cell
    }

}
