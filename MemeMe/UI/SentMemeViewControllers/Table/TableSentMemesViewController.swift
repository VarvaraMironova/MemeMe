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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let selectedCell = sender as! SentMemesTableViewCell
        selectedItem = rootView.memesTableView.indexPathForCell(selectedCell)!.row
        
        super.prepareForSegue(segue, sender: sender)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemesTableViewCell", forIndexPath: indexPath) as! SentMemesTableViewCell
        cell.fillWithModel(memes[indexPath.row])
        
        return cell
    }
}
