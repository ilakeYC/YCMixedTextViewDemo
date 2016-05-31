//
//  YCMixedTextItem.swift
//  YCMixedTextView
//
//  Created by LakesMac on 16/5/31.
//  Copyright © 2016年 iLakeYC. All rights reserved.
//

import UIKit

enum YCMixedTextItemType {
    case PlainText;
    case Button;
}

class YCMixedTextItem: NSObject {
    
    var text = ""
    var type: YCMixedTextItemType = .PlainText
    var color: String = "#000000"
    var fontSize = 13
    var textDecoration = false
    
    override init() {
        super.init()
    }
    
    init(type: YCMixedTextItemType) {
        super.init()
        self.type = type
        if type == .Button {
            self.color = "#354d80"
        }
    }
    
    var hrefText : String {
        return text.dataUsingEncoding(NSUTF8StringEncoding)!.base64EncodedStringWithOptions(.EncodingEndLineWithLineFeed)
    }
    
    var html : String {
        return "<\(html_mark)"
            + html_href
            + " style=\""
            + html_color
            + html_fontSize
            + html_textDecoration
            + "\">"
            + text
            + "</\(html_mark)>"
    }
}

extension YCMixedTextItem {
    
}

private extension YCMixedTextItem {
    var html_mark : String {
        switch type {
        case .Button:
            return "a"
            
        case .PlainText :
            return "span"
        }
    }
    
    var html_href : String {
        switch type {
        case .Button:
            return " href=\"#\(hrefText)\""
        case .PlainText :
            return ""
        }
    }
    
    var html_color : String {
        return " color: \(color);"
    }
    
    var html_fontSize: String {
        return " font-size: \(fontSize)px;"
    }
    
    var html_textDecoration : String {
        return " text-decoration : \(textDecoration ? "underline" : "none");"
    }
}