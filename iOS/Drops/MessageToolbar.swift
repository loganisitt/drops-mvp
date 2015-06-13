//
//  MessageToolbar.swift
//  Drops
//
//  Created by Logan Isitt on 5/10/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

protocol MessageToolbarDelegate: UIToolbarDelegate {
    func sendMessage(content: String)
    func scrollUp()
}


class MessageToolbar: UIToolbar {
    
    @IBOutlet var contentBarBtn: UIBarButtonItem!
    @IBOutlet var contentField: UITextField!
    @IBOutlet var sendBtn: UIBarButtonItem!
    
    @IBOutlet var frontSpacing: UIBarButtonItem!
    @IBOutlet var backSpacing: UIBarButtonItem!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
                
        contentField = UITextField()
        contentField.borderStyle = UITextBorderStyle.RoundedRect
        
        contentBarBtn = UIBarButtonItem(customView: contentField)
        
        sendBtn = UIBarButtonItem(title: "Send", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("sendAction"))
        
        frontSpacing = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: self, action: Selector())
        backSpacing = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: self, action: Selector())
        
        setItems([frontSpacing, contentBarBtn, sendBtn, backSpacing], animated: true)
        
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buffer = CGFloat(8)
        
        sendBtn.width = 50
        
        var rect = contentField.frame
        rect.size.width = frame.width - (sendBtn.width + (buffer * 3))
        rect.size.height = 31
        contentField.frame = rect

        contentBarBtn.width = contentField.frame.width
        
        frontSpacing.width = -16
        backSpacing.width = frontSpacing.width
    }
    
    // MARK: - Actions
    
    @IBAction func sendAction() {
        (delegate as! MessageToolbarDelegate).sendMessage(contentField.text)
        contentField.text = ""
    }
}