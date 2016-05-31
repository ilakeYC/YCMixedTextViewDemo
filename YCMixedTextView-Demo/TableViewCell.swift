//
//  TableViewCell.swift
//  YCMixedTextView-Demo
//
//  Created by LakesMac on 16/5/31.
//  Copyright © 2016年 iLakeYC. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var userNameButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var textView: YCMixedTextView!
    
    var didSelectedButtonItem: ((YCMixedTextItem)->())?
    
    
    var model: Model! {
        didSet {
            userNameButton.setTitle(model.userName, forState: .Normal)
            
            let item0 = YCMixedTextItem(type: .Button)
            item0.text = model.replyToUserName
            let item1 = YCMixedTextItem(type: .PlainText)
            item1.text = model.replyContent
            
            let item2 = YCMixedTextItem(type: .Button)
            item2.text = " @userName"
            textView.load([
                item0, item1, item2, item2
                ])
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func Height(model: Model) -> CGFloat {
        let string = model.replyToUserName + model.replyContent
        let frame = NSString(string: string).boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.width - 16, 100), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [
            NSFontAttributeName: UIFont.systemFontOfSize(13)
            ], context: nil)
        return frame.height + 54
    }

}

extension TableViewCell: YCMixedTextViewDelegate {
    
    func mixedTextView(view: YCMixedTextView, didSelectedButtonItem item: YCMixedTextItem) {
        didSelectedButtonItem?(item)
    }
    
}