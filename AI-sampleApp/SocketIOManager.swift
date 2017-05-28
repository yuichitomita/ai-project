//
//  SocketIOManager.swift
//  AI-sampleApp
//
//  Created by Tomi on 2017/05/28.
//  Copyright © 2017年 slj. All rights reserved.
//

import Foundation
import SocketIO
import JSQMessagesViewController

class SocketIOManager: NSObject {
    //Singleton
    class var sharedInstance: SocketIOManager {
        struct Static {
            static let instance: SocketIOManager = SocketIOManager()
        }
        return Static.instance
    }
    
    private override init() {super.init()}
    
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string:"http://153.126.157.154:1337") as! URL)
    
    //接続
    func establishConnection(){
        socket.joinNamespace("/chat")
        socket.on("connect") { data in
            print("iOS側からサーバーへsocket接続")
        }
        socket.connect()
    }
    
    //切断
    func closeConnection() {
        socket.on("disconnect"){ data in
            print("socketが接続されました")
        }
        socket.disconnect()
    }
    
    //メッセージ送信
    func sendMessage(_ room: String, userId: String, message: String, name: String) {
        let data = ["room":room,"userId":userId,"userName":name,"msg":message]
        socket.emit("from_client", data)
    }
    
    //メッセージ受信
    func getChatmessage(_ completionHandler: @escaping (_ messageInfo: JSQMessage) -> Void) {
        socket.on("from_server"){ (dataArray, socketAck) -> Void in
            print(dataArray[0])
            let message = dataArray[0] as! String
            let jsqMessage = JSQMessage(senderId: "Other", displayName: "B", text: message)
            completionHandler(jsqMessage!)
        }
    }
    
    //room参加
    func joinRoom(_ room: String) {
        //let data = ["room": room]
        socket.emit("join_room", room)
    }
    
   
}
