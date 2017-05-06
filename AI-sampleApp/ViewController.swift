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
    private var myTabBar:UITabBar!
    
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
        
        self.view.backgroundColor = UIColor.lightGray
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
        //デフォルトは49
        let tabBarHeight:CGFloat = 49
        
        /**   TabBarを設置   **/
        myTabBar = UITabBar()
        myTabBar.frame = CGRect(x:0,y:height - tabBarHeight,width:width,height:tabBarHeight)
        //バーの色
        myTabBar.barTintColor = UIColor.lightGray
        //選択されていないボタンの色
        myTabBar.unselectedItemTintColor = UIColor.white
        //ボタンを押した時の色
        myTabBar.tintColor = UIColor.blue
        
        //ボタンを生成
        let company:UITabBarItem = UITabBarItem(title: "企業", image: UIImage(named: "company"), tag: 1)
        let message:UITabBarItem = UITabBarItem(title: "マッチング", image: UIImage(named: "message"), tag: 2)
        let more:UITabBarItem = UITabBarItem(tabBarSystemItem: .more,tag:3)
        //ボタンをタブバーに配置する
        myTabBar.items = [company,message,more]
        //デリゲートを設定する
        myTabBar.delegate = self
        
        self.view.addSubview(myTabBar)
    }
    

}

