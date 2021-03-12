//
//  AppDelegate.swift
//  MemeMe
//
//  Created by Varvara Mironova on 04.06.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var memes = [MemeModel]()
    
    func application(_ application                               : UIApplication,
                     didFinishLaunchingWithOptions launchOptions : [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
    {
        return true
    }
}

