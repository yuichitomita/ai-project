//
//  ViewController.swift
//  AI-sampleApp
//
//  Created by Tomi on 2017/05/06.
//  Copyright © 2017年 slj. All rights reserved.
//

import UIKit
import SnapKit
import ZLSwipeableViewSwift

class ViewController: UIViewController, UITabBarDelegate {
    let swipeableView = ZLSwipeableView()
    let images = [UIImage(named: "bey"), UIImage(named: "pb"), UIImage(named: "kyouken"), UIImage(named: "cookingpapa")]
    var imageIndex = 0
    private var tabBar:UITabBar!
    
    override func viewDidLayoutSubviews() {
        swipeableView.nextView = {
            return self.nextCardView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.view.addSubview(self.swipeableView)
        self.swipeableView.snp.makeConstraints { make in
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.top.equalTo(self.view).offset(120)
            make.bottom.equalTo(self.view).offset(-100)
        }
        swipeableView.didStart = {view, location in
            print("Did start swiping view at location: \(location)")
        }
        swipeableView.swiping = {view, location, translation in
            print("Swiping at view location: \(location) translation: \(translation)")
        }
        swipeableView.didEnd = {view, location in
            print("Did end swiping view at location: \(location)")
        }
        swipeableView.didSwipe = {view, direction, vector in
            print("Did swipe view in direction: \(direction), vector: \(vector)")
        }
        swipeableView.didCancel = {view in
            print("Did cancel swiping view")
        }
        swipeableView.didTap = {view, location in
            print("Did tap at location \(location)")
        }
        swipeableView.didDisappear = { view in
            print("Did disappear swiping view")
        }
        
    }

    func nextCardView() -> CardView? {
        if imageIndex >= images.count {
            imageIndex = 0
        }
        
        let cardView = CardView(frame: swipeableView.bounds)
        guard let image = images[imageIndex] else { return cardView }
        cardView.setImage(image: image)
        imageIndex += 1
        
        return cardView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setup() {
        let width = self.view.frame.width
        let height = self.view.frame.height
        let tabBarHeight:CGFloat = 49
        
        //UIColor: Mercury
        self.view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        self.title = "新しい会社と出会う"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 17.0),
                                                                        NSForegroundColorAttributeName : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        
        tabBar = UITabBar()
        tabBar.frame = CGRect(x:0,y:height - tabBarHeight,width:width,height:tabBarHeight)
        tabBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        tabBar.tintColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        
        let company:UITabBarItem = UITabBarItem(title: "企業", image: UIImage(named: "company"), tag: 1)
        let message:UITabBarItem = UITabBarItem(title: "マッチング", image: UIImage(named: "message"), tag: 2)
        let more:UITabBarItem = UITabBarItem(tabBarSystemItem: .more,tag:3)
        
        tabBar.items = [company,message,more]
        tabBar.delegate = self
        
        self.view.addSubview(tabBar)
    }
    

}

