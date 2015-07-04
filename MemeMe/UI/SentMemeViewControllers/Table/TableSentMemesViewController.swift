//
//  TableSentMemesViewController.swift
//  MemeMe
//
//  Created by Varvara Mironova on 20.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class TableSentMemesViewController: SentMemesViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var rootView: TableSentMemesRootView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // In my opinion, it would be better to create arrayModel to store memes and make it observable.
        // Array model should can load self and has property state (notLoaded, loaded, loading, etc.)
        // TableViewDataSource (tableViewDelegate) and collectionViewDataSource (CollectionViewDelegate)
        // should observe arrayModel. if it not loaded -> show activity indicator in rootView;
        // when they get notification of modelDidLoad -> hide activityIndicator
        // Please, let me know if I'm wrong
        rootView.memesTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemesTableViewCell", forIndexPath: indexPath) as! SentMemesTableViewCell
        cell.fillWithModel(memes[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let destinationController = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        destinationController.memeModel = memes[indexPath.row]

        navigationController!.pushViewController(destinationController, animated: true)
    }
}
