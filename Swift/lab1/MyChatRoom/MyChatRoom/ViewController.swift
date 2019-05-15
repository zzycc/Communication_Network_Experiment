//
//  ViewController.swift
//  MyChatRoom
//
//  Created by ESD 24 on 2018/11/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!    
    @IBOutlet weak var chatContentTextView: UITextView!
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func sendButtonPressed(_ sender: AnyObject) {
        let message = self.messageTextField.text!
        self.i = self.i + 1
        let newChatContent = "[\(self.i)] \(message)\n\(self.chatContentTextView.text!)"
        
        self.chatContentTextView.text = newChatContent
        self.messageTextField.text = ""
    }
}

