//
//  MessageListViewController.swift
//  AI-sampleApp
//
//  Created by Tomi on 2017/05/30.
//  Copyright © 2017年 slj. All rights reserved.
//

import UIKit

class MessageListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
    }
}

extension MessageListViewController: UITableViewDelegate {
    //cellがタップされたのを検知した時に実行する処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セルがタップされたよ！")
    }
}
