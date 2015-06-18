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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        application.statusBarHidden = true;
        
        return true
    }
}

