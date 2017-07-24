//
//  CardView.swift
//  AI-sampleApp
//
//  Created by Tomi on 2017/05/06.
//  Copyright © 2017年 slj. All rights reserved.
//

import UIKit
import SnapKit

class CardView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    
    var nibName: String = "CardView"
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // Xib読み込み時に呼ばれる（ViewControllerのviewDidLoad的なもの）
    override func awakeFromNib() {
        print("awakeFromNib")
    }
    // AutoLayoutなどサブビューのレイアウト適用後に呼ばれる
    override func layoutSubviews() {
        print("layoutSubviews")
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        addSubview(view)
        
        //Shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        view.layer.shadowRadius = 4.0
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        
        // Corner Radius
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        
    }
    
    func setImage(image: UIImage) {
        self.imageView.image = image
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
}
