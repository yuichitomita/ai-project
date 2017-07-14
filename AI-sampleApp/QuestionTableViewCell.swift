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
    func fill (question: Question) {
        questionLabel.text = question.id + "." + question.text
    }
}
