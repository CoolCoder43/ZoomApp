//
//  AppDelegate.swift
//  Pro
//
//  Created by Deepak Dubey on 02/04/22.
//

import UIKit
import Firebase


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    enum s:Int{
        case v,k,g = 3
        static subscript(n:Int)-> s?{
            return s(rawValue: n)
        }
    }



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let l = s[2]
print(l)
        let xu:String?? = .some(nil)
        print(xu)
        // Override point for customization after application launch.
        let f = NSString("a")
        let b = String(f)
        print(b)
        var x:Int? = nil
        x? = 10
        print(x)
        FirebaseApp.configure()
        
        
        let gh = 15
        var fds = 0
        switch(gh){
        case 1...15:
            fds = 1
            fallthrough
        case 2:
            fds = 100
        case 5:
            fds = 100
        default:
            fds = 104
        }
        
        print(fds)
        
        
        
        
        
        
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

