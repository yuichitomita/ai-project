//
//  PostsTableViewCell.swift
//  AI-sampleApp
//
//  Created by Tomi on 2017/07/07.
//  Copyright © 2017年 slj. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    //プロフィール画像url
    @IBOutlet weak var profileImageView: UIImageView!
    //会社名ラベル
    @IBOutlet weak var companyName: UILabel!
    //業種ラベル
    @IBOutlet weak var companyTypeLabel: UILabel!
    //本文ラベル
    @IBOutlet weak var textContentLabel: UILabel!

    func fill(post: Post) {
        // profileImageURLから画像をダウンロードしてくる処理
        let downloadTask = URLSession.shared.dataTask(with: URL(string: post.user.profileImageURL)!) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self?.profileImageView.image = UIImage(data: data!)
            }
        }
        downloadTask.resume()
        companyName.text = post.user.companyName
        companyTypeLabel.text = post.user.companyType
        textContentLabel.text = post.text
    }
    
}
