//
//  AppDelegate.swift
//  Navigation
//
//  Created by Никита  on 04.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
       
        var window: UIWindow?
        var navigationController: UINavigationController?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

            window = UIWindow(frame: UIScreen.main.bounds)
            navigationController = UINavigationController(rootViewController: LogInViewController())
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()

            return true
        }
    }



