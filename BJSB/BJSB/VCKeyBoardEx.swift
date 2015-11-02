//
//  VCKeyBoardEx.swift
//  BJSB
//
//  Created by juanq on 15/10/31.
//  Copyright © 2015年 juanq. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func registrationkeyBoardChangeFrame()
    {
        //监控键盘 键盘显示并且变化 在键盘出现或者在键盘由英文变为中文状态的时候调用
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyBoardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyBoardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
        
    }
    //MARK: - 监控键盘高度的变化
    func keyBoardWillShow(note:NSNotification)
    {
        let userInfo  = note.userInfo
        let  keyBoardBounds = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        self.keyBoardWillChangeWith(keyBoardBounds.size.height)
        
    }
    func keyBoardWillHide(note:NSNotification)
    {
        self.keyBoardWillChangeWith(0)
        
    }
    func keyBoardWillChangeWith(keyboardHeight:CGFloat){
    
    }

}



