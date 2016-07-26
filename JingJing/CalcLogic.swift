//
//  CalcLogic.swift
//  JingJing
//
//  Created by 杨海涛 on 16/7/26.
//  Copyright © 2016年 yanghaitao. All rights reserved.
//

import Foundation


//枚举
enum Operator : Int {
    case Plus = 200, Minus, Mutiply, Divide
    case Default = 0
}

@objc class CalcLogic : NSObject {
   
    //保存上一次的值
    var lastRetainValue : Double
    //最近一次的操作符
    var opr : Operator
    //临时保存MainLabel内容 为true是，输入数据MainLabel内容被清为0
    var isMainLabelTextTemporary : Bool
    
    //构造器
    override init() {
        print("CalcLogic init")
        lastRetainValue = 0.0
        isMainLabelTextTemporary = false
        opr = .Default
        
    }
    
    //析构器
    deinit{
        print("CalcLogic deinit")
    }
    //判断是否有小数点
    func doesStringContainDecimal(strin : String) -> Bool{
        
       return strin.containsString(".")
        
    }
        
    //更新主标签方法
    func updateMainLabelStringByNumberTag(tag : Int, withMainLabelString mainLabelString :String ) ->String{
        var string  = mainLabelString
        
        if (isMainLabelTextTemporary){
            string = "0"
            isMainLabelTextTemporary = false
        }
        
        let optNumber = tag - 100
        //string 转化成Double
        var mainLabelDouble = (string as NSString).doubleValue
        
        if mainLabelDouble == 0 && doesStringContainDecimal(string) == false{
            return String(optNumber)
            
        }
        let resultString = string + String(optNumber)
        return resultString;
    }
    //计算方法
    func calculateByTag(tag : Int ,withMainLabelString mainLabelString : String
        ) -> String{
            //string 转成double
            var currentValue = (mainLabelString as NSString).doubleValue
            
            switch opr {
            case .Plus:
                lastRetainValue += currentValue;
            case .Minus:
                lastRetainValue -= currentValue;
            case .Mutiply:
                lastRetainValue *= currentValue;
            case .Divide:
                if currentValue != 0{
                    lastRetainValue /= currentValue;
                }else{
                    opr = .Default
                    isMainLabelTextTemporary = true
                    return "错误"
                }
            default:
                lastRetainValue = currentValue
            }
            //记录当前的操作符
            opr = Operator(rawValue: tag)!
            
            let resultString = NSString(format: "%@", lastRetainValue)
            
            isMainLabelTextTemporary = true
            
            return resultString as String
    }
    
    //清除方法
    func clear() {
        lastRetainValue = 0.0
        isMainLabelTextTemporary = false
        opr = .Default
    }
    
    
    
    
}
