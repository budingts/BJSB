//
//  HomeVC.swift
//  BJSB
//
//  Created by juanq on 15/10/30.
//  Copyright © 2015年 juanq. All rights reserved.
//

import SnapKit
import Alamofire
import PKHUD

class HomeVC: BaseVC {
    
    let allViewTopMain:CGFloat = 100;
    
    
    var duizhangBtn = UIButton()
    var sixianBtn = UIButton()
    var yibaoBtn = UIButton()
    var yearsBtn = UIButton()
    var userInfoBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        
        
       
    }
    func initUI(){
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width;
        let rightMagin = 10;
        let btnWidth = (screenWidth-40)/3
        self.view.addSubview(duizhangBtn);
        self.view.addSubview(sixianBtn)
        self.view.addSubview(yibaoBtn)
        self.view.addSubview(yearsBtn)
        self.view.addSubview(userInfoBtn)
        
        
        //对账单
        duizhangBtn.snp_makeConstraints { (make) -> Void in
          make.top.equalTo(self.view).offset(allViewTopMain)
          make.left.equalTo(self.view.snp_left).offset(rightMagin)
          make.width.equalTo(btnWidth)
          make.height.equalTo(btnWidth)
        
        };
        duizhangBtn.setTitle("对账单", forState: UIControlState.Normal);
        duizhangBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        duizhangBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        duizhangBtn.backgroundColor = UIColor.colorFromRGB(255, g: 172, b: 58, a: 1.0)
        duizhangBtn.addTarget(self, action: "duizhangdanAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //医保查询
        sixianBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(allViewTopMain)
            make.left.equalTo(self.duizhangBtn.snp_right).offset(rightMagin)
            make.width.equalTo(btnWidth)
            make.height.equalTo(btnWidth)
            
        };
        sixianBtn.setTitle("四险缴费\n查询", forState: UIControlState.Normal);
        sixianBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        sixianBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        sixianBtn.backgroundColor = UIColor.colorFromRGB(255, g: 172, b: 58, a: 1.0)
        sixianBtn.addTarget(self, action: "sixianAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        //四险
        yibaoBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(allViewTopMain)
            make.left.equalTo(self.sixianBtn.snp_right).offset(rightMagin)
            make.width.equalTo(btnWidth)
            make.height.equalTo(btnWidth)
            
        };
        yibaoBtn.setTitle("四险缴费\n查询", forState: UIControlState.Normal);
        yibaoBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        yibaoBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        yibaoBtn.backgroundColor = UIColor.colorFromRGB(255, g: 172, b: 58, a: 1.0)
        yibaoBtn.addTarget(self, action: "yibaoAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //年对账单
        yearsBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.duizhangBtn.snp_bottom).offset(rightMagin)
            make.left.equalTo(self.view.snp_left).offset(rightMagin)
            make.width.equalTo(btnWidth)
            make.height.equalTo(btnWidth)
            
        };
        yearsBtn.setTitle("年对账单", forState: UIControlState.Normal);
        yearsBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        yearsBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        yearsBtn.backgroundColor = UIColor.colorFromRGB(255, g: 172, b: 58, a: 1.0)
        yearsBtn.addTarget(self, action: "yearsAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //个人信息
        userInfoBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.duizhangBtn.snp_bottom).offset(rightMagin)
            make.left.equalTo(self.yearsBtn.snp_right).offset(rightMagin)
            make.width.equalTo(btnWidth)
            make.height.equalTo(btnWidth)
            
        };
        userInfoBtn.setTitle("个人信息", forState: UIControlState.Normal);
        userInfoBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        userInfoBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        userInfoBtn.backgroundColor = UIColor.colorFromRGB(255, g: 172, b: 58, a: 1.0)
        userInfoBtn.addTarget(self, action: "userAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        
    }
    
    //MARK: - UI事件
    func duizhangdanAction()
    {
        self.navigationController?.pushViewController(DuiZhangVC(), animated: true);
    }
    func sixianAction()
    {
        self.navigationController?.pushViewController(DuiZhangVC(), animated: true);
    }
    func yibaoAction()
    {
        self.navigationController?.pushViewController(DuiZhangVC(), animated: true);
    }
    func yearsAction()
    {
        self.navigationController?.pushViewController(DuiZhangVC(), animated: true);
    }
    func userAction()
    {
        self.navigationController?.pushViewController(DuiZhangVC(), animated: true);
    }


}
