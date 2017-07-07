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
    
    // テーブル表示用のデータソース
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension MessageListViewController: UITableViewDelegate {
    //cellがタップされたのを検知した時に実行する処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セルがタップされたよ！")
    }
    
    // セルの見積もりの高さを指定する処理
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // セルの高さを指定する処理
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // UITableViewCellの高さを自動で取得する値
        return UITableViewAutomaticDimension
    }
}

extension MessageListViewController: UITableViewDataSource {
    // 何個のcellを生成するかを設定する関数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    // 描画するcellを設定する関数
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell") as! PostsTableViewCell
        
        return cell
    }
}
