//
//  QuestionTableViewCell.swift
//  AI-sampleApp
//
//  Created by Tomi on 2017/07/15.
//  Copyright © 2017年 slj. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    func setup(){
        //フォント
        let attr = NSDictionary(object: UIFont.systemFont(ofSize: 12.0), forKey: NSFontAttributeName as NSCopying)
        segmentedControl.setTitleTextAttributes(attr as [NSObject : AnyObject], for: .normal)
        
        //背景
        segmentedControl.layer.cornerRadius = 4
        segmentedControl.clipsToBounds = true

    }
    
    func fill (question: Question) {
        questionLabel.text = question.id + ". " + question.text
    }
}
