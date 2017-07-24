//
//  TinderUIViewController.swift
//  AI-sampleApp
//
//  Created by Tomi on 2017/07/23.
//  Copyright © 2017年 slj. All rights reserved.
//

import UIKit
import SnapKit

class TinderUIViewController: UIViewController {

    var card: CardView!
    let images = [#imageLiteral(resourceName: "bey"), #imageLiteral(resourceName: "pb"), #imageLiteral(resourceName: "kyouken"), #imageLiteral(resourceName: "cookingpapa")]
    let companyNames = ["株式会社キュービック","株式会社ギフト","株式会社スピードリンクジャパン","株式会社テスト"]
    var idx = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // レコメンド完了表示View
        let completeView = UIView()
        completeView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let completLabel = UILabel()
        completLabel.text = "レコメンド完了しました"
        completLabel.center = completeView.center
        completeView.addSubview(completLabel)
        self.view.addSubview(completeView)
        
        
        
        completeView.snp.makeConstraints { make in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(self.view).offset(80)
            make.bottom.equalTo(self.view).offset(-60)
        }
        
        
        
        for image in images {
            card = CardView()
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panCard(sender:)))
            card.addGestureRecognizer(panGestureRecognizer)
            card.tag = idx
            card.setImage(image: image)
            card.companyName.text = companyNames[idx]
            idx += 1
            self.view.addSubview(card)

            
            self.card.snp.makeConstraints { make in
                make.left.equalTo(self.view).offset(20)
                make.right.equalTo(self.view).offset(-20)
                make.top.equalTo(self.view).offset(80)
                make.bottom.equalTo(self.view).offset(-60)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    func setup() {
        //UIColor: Mercury
        self.view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 17.0),
                                                                        NSForegroundColorAttributeName : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        self.navigationItem.title = "新しい企業と出会う"
    }


    internal func panCard(sender: UIPanGestureRecognizer) {
        let card = sender.view as! CardView
        let point = sender.translation(in: view)
        
        let xFromCenter = card.center.x - view.center.x
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        if xFromCenter > 0 {
            
            card.thumbImageView.image = #imageLiteral(resourceName: "thumsup")
            card.thumbImageView.tintColor = UIColor.green
        } else {
            
            card.thumbImageView.image = #imageLiteral(resourceName: "thumsdown")
            card.thumbImageView.tintColor = UIColor.red
        }
        
        card.thumbImageView.alpha = abs(xFromCenter) / view.center.x
        
        if sender.state == UIGestureRecognizerState.ended {
            
            if card.center.x < 75 {
                // Move off to the left side
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                return
            }else if card.center.x > (view.frame.width - 75){
                // Move off to the right side
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                return
                
            }
            
            UIView.animate(withDuration: 0.2) {
                card.center = self.view.center
                card.thumbImageView.alpha = 0.0
            }
        }

    }
}
