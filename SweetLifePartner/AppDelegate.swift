//
//  AppDelegate.swift
//  SweetLifePartner
//
//  Created by angrej singh on 18/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Braintree

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BTAppSwitch.setReturnURLScheme("com.tp.sweetlifepartner.payments")
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done"
        
        
        if MemberModel.getMemberModel() != nil {
            isUserLogin(true)
        } else {
            isUserLogin(false)
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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("com.tp.sweetlifepartner.payments") == .orderedSame {
            return BTAppSwitch.handleOpen(url, options: options)
        }
        return false
    }
}

extension AppDelegate {
    
    //Check User Login
    func isUserLogin(_ isLogin:Bool) {
        if isLogin {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeTabBar = storyboard.instantiateViewController(withIdentifier: "HomeTabBarVC") as! HomeTabBarVC
            let nav = UINavigationController(rootViewController: homeTabBar)
            nav.isNavigationBarHidden = true
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let splashVC = storyboard.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
            self.window?.rootViewController = UINavigationController(rootViewController: splashVC)
            self.window?.makeKeyAndVisible()
        }
    }
}


//MARK: API Call
//extension AppDelegate {
//    func apiGeneralSetting() {
//
//        if let getRequest = API.GENERALSETTING.request(method: .post, with: nil, forJsonEncoding: true) {
//            Global.showLoadingSpinner()
//            getRequest.responseJSON { (response) in
//                Global.dismissLoadingSpinner()
//                API.GENERALSETTING.validatedResponse(response, completionHandler: { (jsonObject, error) in
//                    guard error == nil, let getData = jsonObject?["data"] as? [String: Any] else {
//                        return
//                    }
//                    self.contactMailId = getData["contact_us_email"] as? String ?? ""
//                    self.fbUrl = getData["facebook_custom_link"] as? String ?? ""
//                    self.siteUrl = getData["site_url"] as? String ?? ""
//                    self.tAndCUrl = getData["terms-conditions"] as? String ?? ""
//                    self.linkdinCustomLink = getData["linkdin_custom_link"] as? String ?? ""
//                    self.privacyURl = getData["confidentialite"] as? String ?? ""
//                    self.instaUrl = getData["instagram_custom_link"] as? String ?? ""
//                    self.appVersion = getData["app_version_ios"] as? String ?? ""
//                })
//            }
//        }
//    }
//}
