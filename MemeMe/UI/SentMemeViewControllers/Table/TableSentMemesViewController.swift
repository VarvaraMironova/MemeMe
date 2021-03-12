//
//  TableSentMemesViewController.swift
//  MemeMe
//
//  Created by Varvara Mironova on 20.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class TableSentMemesViewController: SentMemesViewController,
                                    UITableViewDataSource,
                                    UITableViewDelegate
{
    weak private var rootView: SentMemesRootView? {
        return viewIfLoaded as? SentMemesRootView
    }
    
    //MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // I would preffer to create arrayModel to store memes and make it observable.
        // Array model should load self and has property state (notLoaded, loaded, loading, etc.) to notify when loading's finished
        // TableViewDataSource (tableViewDelegate) and collectionViewDataSource (CollectionViewDelegate) should be arrayModel observers.
        // when loading is finished -> update subviews
        
        //rootView.memesTableView.reloadData()
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView                   : UITableView,
                   numberOfRowsInSection section : Int) -> Int
    {
        return memes?.count ?? 0
    }
    
    func tableView(_ tableView           : UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemesTableViewCell", for: indexPath as IndexPath) as! SentMemesTableViewCell
        if let memes = memes {
            cell.fillWithModel(model: memes[indexPath.row])
        }
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView              : UITableView,
                   didSelectRowAt indexPath : IndexPath)
    {
        if let memes = memes {
            showDetails(meme: memes[indexPath.row])
        }
    }
}
