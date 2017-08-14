//
//  ChatViewController.swift
//  AI-sampleApp
//
//  Created by Tomi on 2017/05/28.
//  Copyright © 2017年 slj. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import SwiftPhoenixClient

class ChatViewController: JSQMessagesViewController {
    var name: String?
    var messages: [JSQMessage] = []
    let socket = Socket(domainAndPort: "ik1-314-17400.vs.sakura.ne.jp:4000", path: "socket", transport: "websocket")
    var topic: String? = "room:lobby"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        senderDisplayName = "とみ"
        senderId = NSUUID().uuidString
        
        self.connectSocket()
        
        //キーボードのジェスチャ-登録
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        self.title = "マッチング"
        
    }
    
    private func connectSocket(){
        
        socket.join(topic: topic!, message: Message(subject: "status", body: "joining")) { channel in
            let chan = channel as! Channel
            chan.on(event: "join") { message in
                print("iOSからサーバーへ接続")
            }
            
            chan.on(event: "new:msg") { message in
                guard let message = message as? Message,
                    let senderId = message["senderId"],
                    let username = message["user"],
                    let body = message["body"] else {
                        return
                }
                let jsqMessage = JSQMessage(senderId: senderId as! String , displayName:  username as! String, text: body as! String)
                self.messages.append(jsqMessage!)
                self.finishReceivingMessage(animated: true)
                
            }

        }
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

        // サーバーへメッセージ送信
        let message = Message(message: ["senderId": senderId, "user": senderDisplayName, "body": text])
        print(message.toJsonString())
        let payload = Payload(topic: topic!, event: "new:msg", message: message)
        socket.send(data: payload)
        
        // TextFieldのテキストをクリア
        self.inputToolbar.contentView.textView.text = ""
        self.inputToolbar.toggleSendButtonEnabled()
        
    }
    
}
