//
//  AppDelegate.swift
//  ShareSpace-personal project
//
//  Created by 任非凡 on 12/9/23.
//

import FirebaseCore
import Firebase
import GoogleSignIn

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        //Initialize Google Maps
        //GMSServices.provideAPIKey("AIzaSyA_dg0gaZpsMYz7GKx_ULh4wA0W4670RvU")
        return true
    }
    
    @available(iOS 9.0, *)
    //it asks the delegate to open the resource specified by the url
    func application(_ application: UIApplication, open url: URL, options:
                     [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool
    {
        return GIDSignIn.sharedInstance.handle(url)
    }
}


