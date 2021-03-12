//
//  TableSentMemesRootView.swift
//  MemeMe
//
//  Created by Varvara Mironova on 20.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

//  This class is inherited from SentMemesRootView which is inherited from UIView (not UIViewController!!!).
//  It is used to override property view in TableViewController. It's besause of
//  according to MVC, view (interface) object knows how to display model.
//  So, in my opinion, outlets as part of interface have to be stored in view

import UIKit

class TableSentMemesRootView: SentMemesRootView {
    @IBOutlet var memesTableView: UITableView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        memesTableView.tableFooterView = UIView()
//    }
}
