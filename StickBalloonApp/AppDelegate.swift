//
//  AppDelegate.swift
//  StickBalloonApp
//
//  Created by 藤田晃弘 on 2017/05/13.
//  Copyright © 2017年 T6SDL. All rights reserved.
//

import UIKit
import NCMB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
//  APIKey
    let applicationKey = "946a59fbe6a70112677f221b76dc5fc738377125811fc48e17f5935b1e43d771"
    let clientKey = "668c346925cb8ca42fa319178c066eb838d13c6219ca0eda5f7531c463626c13"
    
//  sideNumber (WASEDA = 0, KEIO = 1, AUDIENCE = 2)
    var sideNum = UserDefaults.standard
    let userSide: [String] = ["WASEDA", "KEIO", "AUDIENCE"]
    
//  SE name
    let soundFXs: [String] = ["standard", "snare", "whistle", "mario", "human"]
    
//  SE number
    var soundNum = 0
    let soundType: [String] = ["1", "2", "3", "4", "5"]
    
//  Supporters
    var wasedaSup = 0
    var keioSup = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //NCMB
        NCMB.setApplicationKey(applicationKey, clientKey: clientKey)
        
        //time of launchscreen
        sleep(2)
                
        //for firstlaunch
        let launchScreen = UserDefaults.standard
        
        let dict = ["firstlaunch": true]
        
        launchScreen.register(defaults: dict)
        
        if launchScreen.bool(forKey: "firstlaunch") {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "select")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            launchScreen.set(false, forKey: "firstlaunch")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

