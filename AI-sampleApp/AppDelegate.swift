//
//  AppDelegate.swift
//  AI-sampleApp
//
//  Created by Tomi on 2017/05/06.
//  Copyright © 2017年 slj. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //タブバー設定
        let company:UITabBarItem = UITabBarItem(title: "企業", image: #imageLiteral(resourceName: "company"), tag: 1)
        let message:UITabBarItem = UITabBarItem(title: "マッチング", image: #imageLiteral(resourceName: "message"), tag: 2)
        let question:UITabBarItem = UITabBarItem(title: "質問", image: #imageLiteral(resourceName: "question"), tag: 3)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "main") as! TinderUIViewController
        mainVC.tabBarItem = company
        let chatVC = storyboard.instantiateViewController(withIdentifier: "MessageList") as! MessageListViewController
        chatVC.tabBarItem = message
        
        let questionVC = storyboard.instantiateViewController(withIdentifier: "question") as! QuestionViewController
        questionVC.tabBarItem = question
        let navigationController1 = UINavigationController(rootViewController: mainVC)
        let navigationController2 = UINavigationController(rootViewController: chatVC)
        let navigationController3 = UINavigationController(rootViewController: questionVC)
        
        
        let viewControllers = [navigationController1,navigationController2,navigationController3]
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(viewControllers, animated: false)
        
        tabBarController.tabBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBarController.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
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

