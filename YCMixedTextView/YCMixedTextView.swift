//
//  YCMixedTextView.swift
//  YCMixedTextView
//
//  Created by LakesMac on 16/5/31.
//  Copyright © 2016年 iLakeYC. All rights reserved.
//

import UIKit

@objc protocol YCMixedTextViewDelegate {
    
    optional func mixedTextView(view: YCMixedTextView, didSelectedButtonItem item: YCMixedTextItem) -> Void
    
}

class YCMixedTextView: UIView {
    private var items = [YCMixedTextItem]()
    
    var delegate : YCMixedTextViewDelegate?
    
    var background_color: String = "#FFFFFF" {
        didSet {
            reload()
        }
    }
    
    func load(items: [YCMixedTextItem]) {
        self.items = items
        reload()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAllViews()
    }
    
    
    private let webView = UIWebView(frame: .zero)
    func setupAllViews() {
        addSubview(webView)
        webView.opaque = false
        webView.backgroundColor = .clearColor()
        webView.scrollView.backgroundColor = .whiteColor()
        webView.scrollView.scrollEnabled = false
        webView.delegate = self
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    override func layoutSubviews() {
        webView.frame = bounds
    }
}

extension YCMixedTextView: UIWebViewDelegate {
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.URL?.absoluteString {
            if let href = url.componentsSeparatedByString("#").last {
                for item in items {
                    if href == item.hrefText {
                        delegate?.mixedTextView?(self, didSelectedButtonItem: item)
                        return true
                    }
                }
            }
        }
        return true
    }
}

private extension YCMixedTextView {
    func reload() {
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    var htmlString : String {
        return "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><script type=\"text/JavaScript\">window.onload=function(){document.documentElement.style.webkitTouchCallout='none';document.documentElement.style.webkitUserSelect='none';};</script></head>"
            + "<body style=\"background-color: \(background_color); margin: 0; padding: 0; border: none; font-family: \"Helvetica\";\">"
            + (items.map{"\($0.html)"}).joinWithSeparator("")
            + "</body></html>"
    }
}