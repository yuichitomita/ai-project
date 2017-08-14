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
        setupAppearance()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // ダミーデータ作成
        let company = Company(id: "1", companyName: "スピードリンクジャパン", companyType: "SE エンジニア", profileImageURL: "https://pbs.twimg.com/profile_images/817331078260101122/XM1FgdlH.jpg")
        let post = Post(id: "1", text: "マッチングしました", company: company)
        let posts = [post]
        self.posts = posts
        
        tableView.reloadData()
        
    }
    
    func setupAppearance() {
        navigationItem.title = "マッチング"
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButtonItem
    }

    
}

extension MessageListViewController: UITableViewDelegate {
    //cellがタップされたのを検知した時に実行する処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セルがタップされたよ！")
        let targetViewController = ChatViewController()
        //遷移時にタブバーを隠す
        targetViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(targetViewController, animated: false)
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
        cell.fill(post: posts[indexPath.row])
        return cell
    }
}
