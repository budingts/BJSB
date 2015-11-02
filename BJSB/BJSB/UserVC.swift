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

class UserVC: BaseVC {
    
    var webView = UIWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.loadData()
        
    }
    
    func initUI(){
        self.view.addSubview(webView)
        webView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp_top)
            make.left.equalTo(self.view.snp_left)
            make.right.equalTo(self.view.snp_right)
            make.bottom.equalTo(self.view.snp_bottom)
            
        };
        
    }
    
    
    
    func loadData(){
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        let url = NetUtils().SERVER_URL+"/csibiz/indinfo/search/ind/indNewInfoSearchAction"
        Alamofire.request(.POST, url, parameters: nil)
            .response { request, response, data, error in
                //self.webView.loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
                
                let dataStr = NSString(data:data!, encoding:NSUTF8StringEncoding) as! String
                print(dataStr)
                self.webView.loadHTMLString(dataStr, baseURL: nil)
                PKHUD.sharedHUD.hide()
                
                
        }
        
    }
    
    
}
