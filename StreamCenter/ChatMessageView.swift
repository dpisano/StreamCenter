//
//  ChatMessageView.swift
//  GamingStreamsTVApp
//
//  Created by Olivier Boucher on 2015-09-23.

import UIKit
import Foundation


class ChatMessageView : UIView {
    let message : NSAttributedString
    
    init(message: NSAttributedString, width : CGFloat, position : CGPoint) {
        let desiredFont = UIFont.systemFontOfSize(29)
        let mutableMessage : NSMutableAttributedString = message.mutableCopy() as! NSMutableAttributedString
        mutableMessage.addAttribute(NSFontAttributeName, value: desiredFont, range: NSMakeRange(0, message.length))
        self.message = mutableMessage as NSAttributedString

        let maxSize = CGSize(width: width, height: 10000)
        let size = self.message.boundingRectWithSize(maxSize, options: [.UsesLineFragmentOrigin, .UsesFontLeading], context: nil)
        
        super.init(frame: CGRect(origin: position, size: CGSize(width: width, height: size.height+10)))
        self.backgroundColor = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        self.message = NSAttributedString(string: "")
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        message.drawInRect(rect)
    }
}
