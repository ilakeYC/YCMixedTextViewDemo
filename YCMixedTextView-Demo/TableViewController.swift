//
//  TableViewController.swift
//  YCMixedTextView-Demo
//
//  Created by LakesMac on 16/5/31.
//  Copyright © 2016年 iLakeYC. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var models : [Model] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareModels()
        tableView.reloadData()
    }
    
    func prepareModels() {
        models += [
            Model(userName: "大麻七", replyToUserName: "@小六子", replyContent: "：很有意思哈"),
            Model(userName: "丁国军", replyToUserName: "@李大叔", replyContent: "：坟头草三寸系列"),
            Model(userName: "一星爵一", replyToUserName: "", replyContent: "不用说，又是阿三"),
            Model(userName: "double无聊", replyToUserName: "", replyContent: "你咋不上天呢"),
            Model(userName: "话唠", replyToUserName: "@大话唠", replyContent: "：今天熊孩子补习完回来和我说：“能不能不去辅导班了？”\n我问：“为什么”\n“要是每个礼拜都叫你去加班，你喜欢吗？！”\n我。。。老子是不喜欢加班，还TM不喜欢上班呢，还不是为了赚钱让你上辅导班！！！怎么有种作孽的感觉？！")
        ]
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell

        
        weak var weakSelf = self
        cell.didSelectedButtonItem = {
            item in
            let fooVC = UIViewController()
            fooVC.title = item.text
            fooVC.view.backgroundColor = .whiteColor()
            weakSelf?.navigationController?.pushViewController(fooVC, animated: true)
        }
        
        
        cell.model = models[indexPath.row]

        cell.selectionStyle = .None
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return TableViewCell.Height(models[indexPath.row])
    }

}
