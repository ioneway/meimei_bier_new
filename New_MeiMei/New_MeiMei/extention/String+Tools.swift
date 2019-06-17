//
//  String+Tools.swift
//  tools_swift
//
//  Created by 王伟 on 2018/8/11.
//  Copyright © 2018年 王伟. All rights reserved.
// String  工具

import Foundation

extension String {
    
    func subString(start: Int, length: Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy: start)
        let en = self.index(st, offsetBy: len)
        
        return String(self[st ..< en])
    }
    
    //国际化
    var local: String {
        return NSLocalizedString(self, tableName: "Localizable", comment: "")
    }
    
    
    
    //url
    var url: URL? {
        return URL.init(string: self)
    }
    
    //是否可以转换为数字
    var isNumber: Bool {
        if Double(self) == nil {
            return false
        }else {
            return true
        }
    }
    
    //删除小数点后小数多余的0
    func removeMoreZero() -> String {
        var outNumber = self
        var i = 1
        if self.contains("."){
            while i < self.count{
                if outNumber.hasSuffix("0"){
                    outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
                    i = i + 1
                }else{
                    break
                }
            }
            if outNumber.hasSuffix("."){
                outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
            }
            return outNumber
        }
        return self
    }
    
    //转换为格式化数字字符串，输入必须为数字字符串
    func toNumber(_ numberStyle: NumberFormatter.Style) -> String {
        let format = NumberFormatter()
        if self.isNumber{
            let num = format.number(from: self)
            return format.string(from: num!)!
        }
        fatalError("字符串无法转换为数字")
    }
    
    //提取字符串中的数字
    func extractNum() -> String {
        let scanner = Scanner(string: self)
        scanner.scanUpToCharacters(from: CharacterSet.decimalDigits, into: nil)
        var number :Int = 0
        scanner.scanInt(&number)
        return String(number)
    }
    
    //url转码
    func urlEncode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    //转换为km
//    var km: String {
//        let m = self.decimal / 1000000.0.decimal
//        if m > 1.0.decimal {
//            return m.roundStr_down(2,suffixZero: true) + "M"
//        }
//        let k = self.decimal / 1000.0.decimal
//        if k > 1.0.decimal {
//            return k.roundStr_down(2, suffixZero: true) + "K"
//        }
//        return self.decimal.roundStr_down(2,  suffixZero: true)
//    }
//
//    //个别地方使用： 金额大于1或者等于0时显示2位小数，小于1时显示4位
//    var szMoneyFormat: String {
//        if self.decimal >= 1 || self.decimal == 0{
//            return self.decimal.roundStr_plain(2, suffixZero: true)
//        } else {
//            return self.decimal.roundStr_plain(4, suffixZero: true)
//        }
//    }
    
    enum PWDLevel: String {
        case strong = "强"
        case stand = "中"
        case weak = "弱"
    }
    
    var pwdLevel: PWDLevel {
        let numlist = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        let lowCapitalist = ["A", "B", "C", "D", "F", "E", "G", "H", "I", "J",
                             "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
                             "U", "V", "W", "X", "Y", "Z"]
        let upCapitalist = ["a", "b", "c", "d", "f", "e", "g", "h", "i", "j",
                            "k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
                            "u", "v", "w", "x", "y", "z"]
        let symbolList = [ "~", "`", " ", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "+", "=", "{", "}", "[", "]", "|", ":", ";", "“", "'", "‘", "<", ",", ".", ">", "?", "/", "、"]
        
        var count: Int  = 0
        for  index in self.indices {
            if( numlist.contains(String(self[index])) == true) {
                count = count + 1
                break;
            }
            
        }
        for  index in self.indices {
            if( lowCapitalist.contains(String(self[index])) == true) {
                count = count + 1
                break;
            }
            
        }
        for  index in self.indices {
            if( upCapitalist.contains(String(self[index])) == true) {
                count = count + 1
                break;
            }
            
        }
        for  index in self.indices {
            if( symbolList.contains(String(self[index])) == true) {
                count = count + 1
                break;
            }
        }
        
        if count < 2  {
            return .weak
        }else if (count == 2 && self.count >= 8) {
            return .stand
        }else if (count > 2 && self.count >= 8)  {
            return .strong
        }
        
        return .weak
    }
    
    /// 转换，解决错误：Unprintable ASCII character found in source file swift
    func convertString() -> String {
        let data = self.data(using: String.Encoding.ascii, allowLossyConversion: true)
        return NSString(data: data!, encoding: String.Encoding.ascii.rawValue)! as String
    }
    
    var isPhone: Bool {
        if let _ = self.range(of: "^1[3|4|5|7|9|8][0-9]{9}$", options: .regularExpression) {
            return true
        }
        return false
    }
    
    /// 手机号脱敏
    var desalinationPhone: String {
        
        if (self.isPhone == true) {
            
            let prefix = self.subString(start: 0, length: 3)
            let surfix = self.subString(start: 7, length: 4)
            
            return prefix + "****" + surfix
        }
        
        return self
    }
    
    /// 卡号脱敏
    var desalinationBanknum: String {
        
        if (self.validBank == true) {
            
            let surfix = self.subString(start: self.count - 4, length: 4)
            
            return "**** **** ****" + surfix
        }
        
        return self
    }
    
    /// 身份证格式校验
    ///
    /// - Returns: 返回
    func jusdgeIdenty() -> Bool {
        let regex = "^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    /// 是否是银行卡号
    var validBank: Bool {
        let regex = "^(\\d{16}|\\d{19})$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    
    
    /// 检测是否事正确的身份证号码
    func isTrueIDNumber() -> Bool{
        
        var value = self
        
        value = value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        var length : Int = 0
        
        length = value.count
        
        if length != 15 && length != 18{
            //不满足15位和18位，即身份证错误
            return false
        }
        
        // 省份代码
        let areasArray = ["11","12", "13","14", "15","21", "22","23", "31","32", "33","34", "35","36", "37","41", "42","43", "44","45", "46","50", "51","52", "53","54", "61","62", "63","64", "65","71", "81","82", "91"]
        
        // 检测省份身份行政区代码
        let index = value.index(value.startIndex, offsetBy: 2)
        let valueStart2 = value.substring(to: index)
        
        //标识省份代码是否正确
        var areaFlag = false
        
        for areaCode in areasArray {
            
            if areaCode == valueStart2 {
                areaFlag = true
                break
            }
        }
        
        if !areaFlag {
            return false
        }
        
        var regularExpression : NSRegularExpression?
        
        var numberofMatch : Int?
        
        var year = 0
        
        switch length {
        case 15:
            
            //获取年份对应的数字
            let valueNSStr = value as NSString
            
            let yearStr = valueNSStr.substring(with: NSRange.init(location: 6, length: 2)) as NSString
            
            year = yearStr.integerValue + 1900
            
            if year % 4 == 0 || (year % 100 == 0 && year % 4 == 0) {
                //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                //测试出生日期的合法性
                regularExpression = try! NSRegularExpression.init(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$", options: NSRegularExpression.Options.caseInsensitive)
            }else{
                
                //测试出生日期的合法性
                regularExpression = try! NSRegularExpression.init(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$", options: NSRegularExpression.Options.caseInsensitive)
            }
            
            numberofMatch = regularExpression?.numberOfMatches(in: value, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange.init(location: 0, length: value.count))
            
            if numberofMatch! > 0 {
                return true
            }else{
                
                return false
            }
            
        case 18:
            
            let valueNSStr = value as NSString
            
            let yearStr = valueNSStr.substring(with: NSRange.init(location: 6, length: 4)) as NSString
            
            year = yearStr.integerValue
            
            if year % 4 == 0 || (year % 100 == 0 && year % 4 == 0) {
                
                //测试出生日期的合法性
                regularExpression = try! NSRegularExpression.init(pattern: "^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$", options: NSRegularExpression.Options.caseInsensitive)
                
            }else{
                
                //测试出生日期的合法性
                regularExpression = try! NSRegularExpression.init(pattern: "^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$", options: NSRegularExpression.Options.caseInsensitive)
            }
            
            numberofMatch = regularExpression?.numberOfMatches(in: value, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange.init(location: 0, length: value.count))
            
            print("numberofMatch=========\(String(describing: numberofMatch))")
            
            if numberofMatch! > 0 {
                
                let a = getStringByRangeIntValue(Str: valueNSStr, location: 0, length: 1) * 7
                
                let b = getStringByRangeIntValue(Str: valueNSStr, location: 10, length: 1) * 7
                
                let c = getStringByRangeIntValue(Str: valueNSStr, location: 1, length: 1) * 9
                
                let d = getStringByRangeIntValue(Str: valueNSStr, location: 11, length: 1) * 9
                
                let e = getStringByRangeIntValue(Str: valueNSStr, location: 2, length: 1) * 10
                
                let f = getStringByRangeIntValue(Str: valueNSStr, location: 12, length: 1) * 10
                
                let g = getStringByRangeIntValue(Str: valueNSStr, location: 3, length: 1) * 5
                
                let h = getStringByRangeIntValue(Str: valueNSStr, location: 13, length: 1) * 5
                
                let i = getStringByRangeIntValue(Str: valueNSStr, location: 4, length: 1) * 8
                
                let j = getStringByRangeIntValue(Str: valueNSStr, location: 14, length: 1) * 8
                
                let k = getStringByRangeIntValue(Str: valueNSStr, location: 5, length: 1) * 4
                
                let l = getStringByRangeIntValue(Str: valueNSStr, location: 15, length: 1) * 4
                
                let m = getStringByRangeIntValue(Str: valueNSStr, location: 6, length: 1) * 2
                
                let n = getStringByRangeIntValue(Str: valueNSStr, location: 16, length: 1) * 2
                
                let o = getStringByRangeIntValue(Str: valueNSStr, location: 7, length: 1) * 1
                
                let p = getStringByRangeIntValue(Str: valueNSStr, location: 8, length: 1) * 6
                
                let q = getStringByRangeIntValue(Str: valueNSStr, location: 9, length: 1) * 3
                
                let S = a + b + c + d + e + f + g + h + i + j + k + l + m + n + o + p + q
                
                print("S============\(S)")
                
                let Y = S % 11
                
                print("Y========\(Y)")
                
                var M = "F"
                
                let JYM = "10X98765432"
                
                M = (JYM as NSString).substring(with: NSRange.init(location: Y, length: 1))
                
                let lastStr = valueNSStr.substring(with: NSRange.init(location: 17, length: 1))
                
                if lastStr == "x" {
                    if M == "X" {
                        return true
                    }else{
                        
                        return false
                    }
                }else{
                    
                    if M == lastStr {
                        return true
                    }else{
                        
                        return false
                    }
                }
            }else{
                
                return false
            }
            
        default:
            return false
        }
    }
    func getStringByRangeIntValue(Str : NSString,location : Int, length : Int) -> Int{
        
        let a = Str.substring(with: NSRange(location: location, length: length))
        
        let intValue = (a as NSString).integerValue
        
        return intValue
    }
    ///删除前后空格
    func deleteBoundaryBlank() -> String {
        let str = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return str
    }
    
   
    
    public func getHHMMSSFormSS(seconds:Int) -> String {
        let str_hour = NSString(format: "%02ld", seconds/3600)
        let str_minute = NSString(format: "%02ld", (seconds%3600)/60)
        let str_second = NSString(format: "%02ld", seconds%60)
        let format_time = NSString(format: "%@:%@:%@",str_hour,str_minute,str_second)
        return format_time as String
    }
    
    /// 时间转为时间错
    public  var timeStamp: String {
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date = dfmatter.date(from: self)
        
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        return String(dateSt)
    }
    
    /// 15分钟后的时间戳
    public  var timeStamp_after15m: String {
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date = dfmatter.date(from: self)
        if date == nil {
            return "0"
        }
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        return String(dateSt + 15*60)
    }
    
    
    /// 2分钟后的时间戳
    public  var timeStamp_after2m: String {
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date = dfmatter.date(from: self)
        if date == nil {
            return "0"
        }
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        return String(dateSt + 5*60)
    }
    
    /// 24小时后的时间戳
    public  var timeStamp_after24h: String {
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date = dfmatter.date(from: self)
        if date == nil {
            return "0"
        }
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        return String(dateSt + 24*60*60)
    }
    
    
    
}
