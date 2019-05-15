//
//  ViewController.swift
//  MyChatRoom
//
//  Created by ESD 24 on 2018/11/23.
//
//lab２新增
import SocketIO

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!    
    @IBOutlet weak var chatContentTextView: UITextView!
    var i = 0
    
    //lab2新增
    let hostString: String = "http://localhost:3000"
    var socket : SocketIOClient? = nil
    var manager: SocketManager? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //lab2  修改
        //創造連線 的URL物件
        let hostUrl = URL(string: self.hostString)
        //創造Socket Manager，同時設定socket將連線到的URL
        self.manager = SocketManager(socketURL: hostUrl!)
        //從Socket Manager取得SocketIOClient物件
        self.socket = self.manager?.defaultSocket
        //把anyEventCallBack這個function設定成socket中所有event的handler，告訴socket接到所有的 event時都要call anyEventCallBack這個函數
        self.socket!.onAny(anyEventCallBack)
        //把connectCallBack這個functio 設定成socket中 "connect" event的handler，告訴socket接到"connect" event時要call connectCallBack這個函數
        self.socket!.on("connect",callback: connectCallBack)
        //把serverMsgCallBack這個function設定成 "show message on screen" event的handler，告訴 socket接到 "show message on screen" event時要call serverMsgCallBack這個函數
        self.socket!.on("show message on screen", callback: serverMsgCallBack)
        print("--- connecting to \(self.hostString) —")
        //叫socket連線到前 已指定的Server
        self.socket!.connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func sendButtonPressed(_ sender: AnyObject) {
        let message = self.messageTextField.text!
        self.i = self.i + 1
        let newChatContent = "[\(self.i)] \(message)\n\(self.chatContentTextView.text!)"
        
        self.socket!.emit("user send out message", message)
        self.chatContentTextView.text = newChatContent
        self.messageTextField.text = ""
    }
    
    //lab2新增function
    func anyEventCallBack( anyEvent: SocketAnyEvent)
    {
        // 印出所有收到的event跟event附帶的data，debug時可
        //print("--- Got event: \(anyEvent.event), with items: \(anyEvent.items) ---")
    }
    func connectCallBack( data:[Any], ack:SocketAckEmitter)
    {
        print("--- socket connected ---")
        //因為剛連上，Delay 0.5秒，再傳送message，讓server有時間註冊好event
        let deadLine = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: deadLine) {
        //  socket傳送 event + message 給server
        self.socket!.emit("user send out message", "Hello! I've connected!")
        }
    }
    func serverMsgCallBack( data:[Any], ack:SocketAckEmitter)
    {
        print("--- receive \"show message on screen\" event ---")
        //找出message string
        let message: String = (data[0] as! String)
        print("received:\n\n" + "\(message)" + "\n")
        self.chatContentTextView.text = "\(message)\n\(self.chatContentTextView.text!)"
    }
}


