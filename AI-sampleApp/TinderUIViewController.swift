//
//  TinderUIViewController.swift
//  AI-sampleApp
//
//  Created by Tomi on 2017/07/23.
//  Copyright © 2017年 slj. All rights reserved.
//

import UIKit

class TinderUIViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        
        let xFromCenter = card.center.x - view.center.x
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
       
        if xFromCenter > 0 {
            thumbImageView.image = #imageLiteral(resourceName: "thumsup")
            thumbImageView.tintColor = UIColor.green
        } else {
            thumbImageView.image = #imageLiteral(resourceName: "thumsdown")
            thumbImageView.tintColor = UIColor.red
        }
        
        thumbImageView.alpha = abs(xFromCenter) / view.center.x
        
        if sender.state == UIGestureRecognizerState.ended {
            UIView.animate(withDuration: 0.2) {
                card.center = self.view.center
                self.thumbImageView.alpha = 0.0
            }
        }
    }
}
