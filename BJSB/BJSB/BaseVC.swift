//
//  BaseVC.swift
//  BJSB
//
//  Created by juanq on 15/10/30.
//  Copyright © 2015年 juanq. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.navigationController != nil {
            self.view.backgroundColor = UIColor.lightGrayColor()
            // 返回按钮文字
            var temporaryBarButtonItem = UIBarButtonItem(title: "返回", style:UIBarButtonItemStyle.Plain, target: self, action: "clickLeftBarButton")
            temporaryBarButtonItem.title = "返回";
            self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
            // 导航栏背景颜色
            self.navigationController!.navigationBar.barTintColor = UIColor.grayColor()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
