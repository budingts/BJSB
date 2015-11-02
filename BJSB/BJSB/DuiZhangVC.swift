//
//  DuiZhangVC.swift
//  BJSB
//
//  Created by juanq on 15/10/31.
//  Copyright © 2015年 juanq. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire
import Foundation

class DuiZhangVC: BaseVC,UIPickerViewDataSource,UIPickerViewDelegate {

    var topRightLabel = UILabel()
    var currentYearLabel = UIButton()
    var searchBtn = UIButton()
    var tableView = UITableView()
    var pickView = UIPickerView()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.loadData()
        
    }
    
    func initUI(){
        self.title = "对账单查询"
        //#define STATUS_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)//状态栏高度
        //#define NAV_HEIGHT (self.navigationController.navigationBar.frame.size.height)//导航栏高度
        let topMagin = UIApplication.sharedApplication().statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.size.height)!;
        
        self.view.addSubview(topRightLabel)
        self.view.addSubview(currentYearLabel)
        self.view.addSubview(searchBtn)
        self.view.addSubview(tableView)
        self.view.addSubview(pickView)
        
        topRightLabel.snp_makeConstraints { (make) -> Void in
          make.top.equalTo(self.view.snp_top).offset(topMagin)
          make.left.equalTo(self.view.snp_left).offset(10)
          make.width.lessThanOrEqualTo(70)
          make.height.equalTo(44)
        
        };
        
        searchBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp_top).offset(topMagin)
            make.right.equalTo(self.view.snp_right).offset(-10)
            make.width.equalTo(50)
            make.height.equalTo(44)
            
        };

        currentYearLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp_top).offset(topMagin)
            make.left.equalTo(topRightLabel.snp_right).offset(10)
            make.right.equalTo(searchBtn.snp_left).offset(-10)
            make.height.equalTo(44)
            
        };
    
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(currentYearLabel.snp_bottom).offset(2)
            make.left.equalTo(self.view.snp_left).offset(10)
            make.right.equalTo(self.view.snp_right).offset(-10)
            make.bottom.equalTo(self.view.snp_bottom)
        };
        pickView.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view.snp_bottom).offset(190)
            make.left.equalTo(self.view.snp_left).offset(10)
            make.right.equalTo(self.view.snp_right).offset(10)
            make.height.equalTo(190)
        }
        
        
        //顶部搜索栏 左侧标题
        topRightLabel.text = "查询年份"
        topRightLabel.font = UIFont.systemFontOfSize(14.0)
        
        
        currentYearLabel.backgroundColor = UIColor.redColor()
        currentYearLabel.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        currentYearLabel.setTitle("2015", forState: UIControlState.Normal)
        currentYearLabel.addTarget(self, action: "showSelectAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        searchBtn.setTitle("查询", forState: UIControlState.Normal)
        searchBtn.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        
        // 显示选中框
        pickView.backgroundColor = UIColor.grayColor()
        pickView.showsSelectionIndicator = true;
        pickView.dataSource = self;
        pickView.delegate = self;
        
        
    }
    
   
    
    func loadData(){
   
        
    }
    //MARK: - UI事件
    func showSelectAction(){
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.pickView.snp_updateConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(self.view.snp_bottom).offset(0)
            })
            
            }) { (Bool) -> Void in
                
        }
        
    }
    
    //MARK: - pickerview delegate
     func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
     {
        return 1;
     }
     func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
     {
        return 50
     }
     func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
     {
        return 200
     }
     func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
     {
        return 38
     }
     func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
     {
        var dateFormatter2 = NSDateFormatter()
        dateFormatter2.dateFormat = "yyyy"
        var now = NSDate()
        let nowString = dateFormatter2.stringFromDate(now)
        return nowString
     }


}
