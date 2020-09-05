//
//  AppDelegate.swift
//  Armut
//
//  Created by Semafor Teknolojı on 3.09.2020.
//  Copyright © 2020 Semafor Teknolojı. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let userLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if (userLoggedIn){
            let nav = storyboard
                            .instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController
            window.rootViewController = nav
        }else{
            let viewController = storyboard.instantiateViewController(withIdentifier: "page") as!
            PageViewController
            window.rootViewController = viewController
        }
        
         window.makeKeyAndVisible()
        return true
    }

    

}

