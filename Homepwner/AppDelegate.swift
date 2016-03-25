//
//  AppDelegate.swift
//  Homepwner
//
//  Created by Roman Ustiantcev on 15/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let itemStore = ItemStore()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // create an image Store
        let imageStore = ImageStore()
        
        // access the ItemsViewController and set its item store
        let navController = window!.rootViewController as! UINavigationController
        let itemViewController = navController.topViewController as! ItemsViewController
        itemViewController.itemStore = itemStore
        itemViewController.imageStore = imageStore
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {

        let success = itemStore.saveChanges()
        if success {
            print("All items saved")
        } else {
            print("Couldnt save any of the items")
        }
        
    }

    func applicationWillEnterForeground(application: UIApplication) {

    }

    func applicationDidBecomeActive(application: UIApplication) {

    }

    func applicationWillTerminate(application: UIApplication) {

    }


}

