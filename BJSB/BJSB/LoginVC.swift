//
//  LoginVC.swift
//  BJSB
//
//  Created by juanq on 15/10/30.
//  Copyright © 2015年 juanq. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import PKHUD
import Fuzi

class LoginVC: BaseVC,UITextFieldDelegate {

    var usernameField = UITextField()
    var passwordField = UITextField()
    var imageView = UIImageView()//背景图
    var vcodeTF = UITextField()
    var vcodeIMG = UIImageView()
    var loginButton = UIButton()
    
    var textFieldHight:CGFloat=44;
    var textFieldtopMargin:CGFloat=20
    var inputViewTopMaigin:CGFloat=100;
    var inputViewHight:CGFloat=44*4+20*3+100;
 
    
    
    private let backGroundArray = [UIImage(named: "img1.jpg"),UIImage(named:"img2.jpg"), UIImage(named: "img3.jpg"), UIImage(named: "img4.jpg")]
    private var idx: Int = 0
    //MARK: - 系统周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated:false)
        initUI()
        getVCode()
        self.registrationkeyBoardChangeFrame();//监听键盘高度
        

    }
   
    //MARK: - 初始化UI
    func initUI(){
        print(self.view.frame.height)
        if self.view.frame.size.height==480 {
            textFieldtopMargin = 10;
            inputViewTopMaigin = 80
            inputViewHight = textFieldHight*4 + textFieldtopMargin*3+inputViewTopMaigin
        }
        //布局UI----
        self.view.backgroundColor=UIColor.whiteColor();
        self.view.addSubview(imageView)
        self.view.addSubview(usernameField)
        self.view.addSubview(passwordField)
        self.view.addSubview(vcodeTF)
        self.view.addSubview(vcodeIMG)
        self.view.addSubview(loginButton)
        
        imageView.snp_makeConstraints { (make) -> Void in
         make.edges.equalTo(self.view)
        };
        usernameField.snp_makeConstraints { (make) -> Void in
          
            make.centerX.equalTo(self.view)
            make.top.equalTo(inputViewTopMaigin);
            make.width.equalTo(280)
            make.height.equalTo(textFieldHight);
        };
        passwordField.snp_makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(self.view)
            make.top.equalTo(usernameField.snp_bottom).offset(textFieldtopMargin);
            make.width.equalTo(usernameField.snp_width)
            make.height.equalTo(textFieldHight);
        };
        vcodeIMG.snp_makeConstraints { (make) -> Void in
            
            make.right.equalTo(passwordField.snp_right)
            make.top.equalTo(passwordField.snp_bottom).offset(textFieldtopMargin);
            make.width.equalTo(100)
            make.height.equalTo(textFieldHight);
        };
        vcodeTF.snp_makeConstraints { (make) -> Void in
            
            make.right.equalTo(vcodeIMG.snp_left).offset(-10)
            make.top.equalTo(passwordField.snp_bottom).offset(textFieldtopMargin);
            make.left.equalTo(passwordField.snp_left)
            make.height.equalTo(textFieldHight);
        };
        vcodeIMG.backgroundColor = UIColor.yellowColor()
        //覆盖在验证码上面的按钮透明的
        let vcodeBtn = UIButton()
        self.view.addSubview(vcodeBtn)
        vcodeBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(passwordField.snp_right)
            make.top.equalTo(passwordField.snp_bottom).offset(textFieldtopMargin);
            make.width.equalTo(100)
            make.height.equalTo(textFieldHight);
        };
        
        
        
        loginButton.snp_makeConstraints { (make) -> Void in
          
            make.left.equalTo(vcodeTF.snp_left).offset(20)
            make.right.equalTo(passwordField.snp_right).offset(-20)
            make.top.equalTo(vcodeTF.snp_bottom).offset(textFieldtopMargin)
            make.height.equalTo(textFieldHight)
        };
        
        
        
        //设置属性参数----
        usernameField.font = UIFont.systemFontOfSize(21)
        usernameField.textColor = UIColor.greenColor()
        usernameField.placeholder = "请输入用户名"
        usernameField.textAlignment = NSTextAlignment.Center
        usernameField.backgroundColor = UIColor.colorWithHex("#FFFFFF",alpha:0.28)
        usernameField.delegate = self;
        
        passwordField.font = UIFont.systemFontOfSize(21)
        passwordField.textColor = UIColor.greenColor()
        passwordField.placeholder = "请输入密码"
        passwordField.textAlignment = NSTextAlignment.Center
        passwordField.backgroundColor = UIColor.colorWithHex("#FFFFFF",alpha:0.28)
        passwordField.delegate = self;
        
        vcodeTF.font = UIFont.systemFontOfSize(21)
        vcodeTF.textColor = UIColor.greenColor()
        vcodeTF.placeholder = "请输入验证码"
        vcodeTF.textAlignment = NSTextAlignment.Center
        vcodeTF.backgroundColor = UIColor.colorWithHex("#FFFFFF",alpha:0.28)
        vcodeTF.delegate = self;
        
        loginButton.setTitle("登 录", forState: UIControlState.Normal)
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(21)
        loginButton.titleLabel?.textColor = UIColor.whiteColor()
        
    
        usernameField.alpha = 0;
        passwordField.alpha = 0;
        loginButton.alpha   = 0;

        UIView.animateWithDuration(0.7, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.usernameField.alpha = 1.0
            self.passwordField.alpha = 1.0
            self.loginButton.alpha   = 0.9
            }, completion: nil)
        
        
        //模糊背景
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark)) as UIVisualEffectView
        imageView.addSubview(visualEffectView)
        visualEffectView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(imageView)
        };
        visualEffectView.alpha = 0.5
        imageView.image = UIImage(named: "img1.jpg")
        
        //设置控件事件
        // Notifiying for Changes in the textFields
        usernameField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        passwordField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        vcodeTF.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)

        NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: "changeImage", userInfo: nil, repeats: true)
        self.loginButton(false)
        
        loginButton.addTarget(self, action: "loginAction" , forControlEvents: UIControlEvents.TouchUpInside)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:"handleTouches:")
        tapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        vcodeBtn.addTarget(self, action: "getVCode", forControlEvents: UIControlEvents.TouchUpInside)
 
        
    }
    

    //MARK: - UI事件
    //MARK: ---- 获取验证码
    func getVCode(){

        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        let url1 = NetUtils().SERVER_URL+"/csibiz/indinfo/geren.jsp";
        Alamofire.request(.POST, url1, parameters: nil)
            .response { request, response, data, error in
                let url2 = NetUtils().SERVER_URL+"/csibiz/indinfo/validationCodeServlet.do"
                Alamofire.request(.POST, url2, parameters: nil)
                    .response { request, response, data, error in
                        
                        if (error != nil){
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                PKHUD.sharedHUD.hide()
                                PKHUD.sharedHUD.contentView = PKHUDTextView(text: "升级维护中，敬请期待");
                                PKHUD.sharedHUD.show()
                                PKHUD.sharedHUD.hide(afterDelay: 2.0);
                            })
                            return
                        }
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                           
                            let img = UIImage.init(data: data!)
                            self.vcodeIMG.image=img
                            PKHUD.sharedHUD.hide()
                        })
                        
                        
                }
                
        }

        
    }
    //MARK: ---- 点击登录按钮操作
    func loginAction(){
        self.usernameField.text = "411328198405133992"
        self.passwordField.text = "19860515"
        self.usernameField.resignFirstResponder();
        self.passwordField.resignFirstResponder();
        self.vcodeTF.resignFirstResponder();
        //去除空格和回车
        func trimLineString(str:String)->String{
           
            let nowStr = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            return nowStr
        }
        let userName:String = trimLineString(usernameField.text!)
        let password = trimLineString(passwordField.text!)
        let code = trimLineString(vcodeTF.text!);
       
        if userName.isEmpty{
            PKHUD.sharedHUD.contentView = PKHUDTextView(text: "请输入用户名");
            PKHUD.sharedHUD.show()
            PKHUD.sharedHUD.hide(afterDelay: 2.0);
            return;
        }
        if password.isEmpty{
        
            PKHUD.sharedHUD.contentView = PKHUDTextView(text: "请输入密码");
            PKHUD.sharedHUD.show()
            PKHUD.sharedHUD.hide(afterDelay: 2.0);
            return;
        }
        if code.isEmpty{
            
            PKHUD.sharedHUD.contentView = PKHUDTextView(text: "请输入验证码");
            PKHUD.sharedHUD.show()
            PKHUD.sharedHUD.hide(afterDelay: 2.0);
            return;
        }
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        let url = NetUtils().SERVER_URL+"/csibiz/indinfo/login_check"
        let parameters=["j_username":userName,"j_password":password,"safecode":code,"flag":"3","type":"1"]
        Alamofire.request(.POST, url, parameters: parameters)
            .response { request, response, data, error in
            PKHUD.sharedHUD.hide()
            
            let dataStr = NSString(data:data!, encoding:NSUTF8StringEncoding) as! String
                print(dataStr)
            if self.safeguard(dataStr) {//维护中
                PKHUD.sharedHUD.contentView = PKHUDTextView(text: "系统维护中，敬请期待");
                PKHUD.sharedHUD.show()
                PKHUD.sharedHUD.hide(afterDelay: 2.5);
            }else if self.idNothingError(dataStr) {
                PKHUD.sharedHUD.contentView = PKHUDTextView(text: "根据身份证号 查不出任何记录");
                PKHUD.sharedHUD.show()
                PKHUD.sharedHUD.hide(afterDelay: 2.5);
            }else if self.passwordError(dataStr) {
                PKHUD.sharedHUD.contentView = PKHUDTextView(text: "密码错误");
                PKHUD.sharedHUD.show()
                PKHUD.sharedHUD.hide(afterDelay: 2.5);
            }else if self.vcodeError(dataStr){
                PKHUD.sharedHUD.contentView = PKHUDTextView(text: "验证码有误");
                PKHUD.sharedHUD.show()
                PKHUD.sharedHUD.hide(afterDelay: 2.5);
            }else{//登录成功
                NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")
                NSUserDefaults.standardUserDefaults().setObject(password, forKey: "password")
                let shareApp = UIApplication.sharedApplication().delegate as! AppDelegate
                shareApp.showViewController(shareApp.HOME_VC)
            }
            
           
                
        }
        
    }
    
    func textFieldDidChange() {
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty || vcodeTF.text!.isEmpty
        {
            self.loginButton(false)
        }
        else
        {
            self.loginButton(true)
        }
    }
    
    //MARK: - 键盘高度变化,隐藏键盘,调整布局
    func handleTouches(sender:UITapGestureRecognizer){
        self.usernameField.resignFirstResponder();
        self.passwordField.resignFirstResponder();
        self.vcodeTF.resignFirstResponder();
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
        
    }
    override func keyBoardWillChangeWith(keyboardHeight: CGFloat) {

        UIView.animateWithDuration(0.25) { () -> Void in
            if keyboardHeight==0 {
                
                self.view.frame = CGRectMake(0.0,0, self.view.frame.size.width, self.view.frame.size.height);
                
            }else{
                if (self.view.frame.size.height - self.inputViewHight)>keyboardHeight
                {
                }else{
                   
                    let offset = self.view.frame.size.height - self.inputViewHight - keyboardHeight;
                    self.view.frame = CGRectMake(0.0, offset, self.view.frame.size.width, self.view.frame.size.height);

                }
                
            
            }
            
        };
        
    }
    
    //MARK: - 功能部分
    //MARK: ----（其他 按钮可用，改变背景）
    func loginButton(enabled: Bool) -> () {
        func enable(){
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.loginButton.backgroundColor = UIColor.colorWithHex("#33CC00", alpha: 1)
                }, completion: nil)
            loginButton.enabled = true
        }
        func disable(){
            loginButton.enabled = false
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.loginButton.backgroundColor = UIColor.colorWithHex("#333333",alpha :1)
                }, completion: nil)
        }
        return enabled ? enable() : disable()
    }
    
    func changeImage(){
        if idx == backGroundArray.count-1{
            idx = 0
        }
        else{
            idx++
        }
        let toImage = backGroundArray[idx];
        UIView.transitionWithView(self.imageView, duration: 3, options: .TransitionCrossDissolve, animations: {self.imageView.image = toImage}, completion: nil)
        
    }
    //MARK: ---- 是否停机维护
    func safeguard(str:String) -> Bool
    {
        if str.containsString("维护") {
            return true
        }
        return false
    }
    func idNothingError(str:String) -> Bool
    {
        if str.containsString("根据身份证号 查不出任何记录") {
            return true
        }
        return false
    }
    func passwordError(str:String) -> Bool
    {
        if str.containsString("输入的密码验证错误") {
            return true
        }
        return false
    }
    func vcodeError(str:String) -> Bool
    {
        if str.containsString("附加码有误") {
            return true
        }
        return false
    }
    
    
    

}
