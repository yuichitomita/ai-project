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
        
        //NavigationController共通設定
        UINavigationBar.appearance().barTintColor = UIColor.Ai.theme
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 17.0),
                                                            NSForegroundColorAttributeName : UIColor.Ai.fontColor]
        UINavigationBar.appearance().tintColor = UIColor.white
        
        
        //タブバー設定
        let company:UITabBarItem = UITabBarItem(title: "企業", image: #imageLiteral(resourceName: "company"), tag: 1)
        let message:UITabBarItem = UITabBarItem(title: "マッチング", image: #imageLiteral(resourceName: "message"), tag: 2)
        let question:UITabBarItem = UITabBarItem(title: "質問", image: #imageLiteral(resourceName: "question"), tag: 3)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "main") as! RecomendViewController
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

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
}

