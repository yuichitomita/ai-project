//
//  ChatViewController.swift
//  AI-sampleApp
//
//  Created by Tomi on 2017/05/28.
//  Copyright © 2017年 slj. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    var name: String?
    var messages: [JSQMessage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setChatModuleParam()
        
        //キーボードのジェスチャ-登録
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        self.title = "マッチング"
        
    }
    
    func setChatModuleParam(){
        senderDisplayName = "とみ"
        senderId = "self"
        self.name = "テスト"
        
        // Node.jsからのメッセージをブロードキャストし、画面にそれを表示
        SocketIOManager.sharedInstance.getChatmessage{ (messageInfo) -> Void in
            self.messages.append(messageInfo)
            self.finishReceivingMessage(animated: true)
        }
        
        SocketIOManager.sharedInstance.joinRoom(senderDisplayName)

    }
    
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: JSQMessageViewController
extension ChatViewController {
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
    
    //チャットの吹き出し設定
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        if messages[indexPath.row].senderId == senderId {
            return JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        }else {
            return JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    //アバターのイメージ設定
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: messages[indexPath.row].senderDisplayName,
                                                         backgroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                                                         textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                                         font: UIFont.systemFont(ofSize: 10),
                                                         diameter: 30)
    }
    
    // Sendボタンが押された時に呼ばれる
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        // 新しいメッセージデータを追加する
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        self.messages.append(message!)
        self.finishReceivingMessage(animated: true)
        
        //var room = senderDisplayName
        var room = "room-1"
        // サーバーへメッセージ送信
        SocketIOManager.sharedInstance.sendMessage(room, userId: senderId, message: text, name: senderDisplayName)
        
        // TextFieldのテキストをクリア
        self.inputToolbar.contentView.textView.text = ""
        self.inputToolbar.toggleSendButtonEnabled()
        
    }
    
}
