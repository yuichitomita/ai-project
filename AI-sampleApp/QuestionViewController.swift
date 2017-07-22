//
//  QuestionViewController.swift
//  AI-sampleApp
//
//  Created by Tomi on 2017/07/12.
//  Copyright © 2017年 slj. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // テーブル表示用のデータソース
    var questions: [Question] = [Question]()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tableView.delegate = self
        tableView.dataSource = self
        
        // ダミーデータ作成
        let q1  = Question(id: "01", text: "何かを考え、無口になることが多い。")
        let q2  = Question(id: "02", text: "活発な方で、体を動かすことは苦にならない。")
        let q3  = Question(id: "03", text: "いったん決心したことは、ほとんど変えることはない。")
        let q4  = Question(id: "04", text: "たとえ遊びでも、自分の得意でないことは、最初からやらないことにしている。")
        let q5  = Question(id: "05", text: "物事を終えたあと、手落ちがなかったか何度も見直したり確認をする。")
        let q6  = Question(id: "06", text: "掃除などをする時は、徹底的にしないと気がすまない。")
        let q7  = Question(id: "07", text: "ちょっとしたことでも、人と違ったやり方を考える。")
        let q8  = Question(id: "08", text: "いろいろと動きまわるより、静かに落ち着いている方が好きである。")
        let q9  = Question(id: "09", text: "さきの先まで考えないと、行動にうつせない。")
        let q10  = Question(id: "10", text: "じっとおとなしくしているのが苦手である。")
        questions.append(q1)
        questions.append(q2)
        questions.append(q3)
        questions.append(q4)
        questions.append(q5)
        questions.append(q6)
        questions.append(q7)
        questions.append(q8)
        questions.append(q9)
        questions.append(q10)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setup() {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 17.0),
                                                                        NSForegroundColorAttributeName : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navigationItem.title = "Question"
        //戻るボタンセット
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
    
    }


}


extension QuestionViewController: UITableViewDelegate {
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

extension QuestionViewController: UITableViewDataSource {
    // 何個のcellを生成するかを設定する関数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 最終行を追加(+1)
        return questions.count + 1
    }
    
    // 描画するcellを設定する関数
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < questions.count else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "completeCell", for: indexPath) as! CompleteTableViewCell
            // button角丸
            cell.completeButton.layer.cornerRadius = 5.0
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell") as! QuestionTableViewCell
        cell.setup()
        cell.fill(question: questions[indexPath.row])
      
        return cell
    }
}


