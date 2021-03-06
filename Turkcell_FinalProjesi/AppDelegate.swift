//
//  AppDelegate.swift
//  Turkcell_FinalProjesi
//
//  Created by Gulsah Altiparmak on 30.01.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UITabBar.appearance().tintColor = UIColor(red: 253.0/255.0, green: 235.0/255.0, blue: 204.0/255.0, alpha: 1.0)
       
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:  UIColor(red: 253.0/255.0, green: 235.0/255.0, blue: 204.0/255.0, alpha: 1.0), NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 20.0)!]
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)]
        if let customFont = UIFont(name: "Roboto-Medium", size: 20.0) {
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont], for: .normal)
        }
       
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

