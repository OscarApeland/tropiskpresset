//
//  AppDelegate.swift
//  PianoApp
//
//  Created by Oscar Apeland on 06/08/2018.
//  Copyright © 2018 OleR. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window!.backgroundColor = .white
        window!.rootViewController = ViewController()
        window!.makeKeyAndVisible()
        
        return true
    }
}

