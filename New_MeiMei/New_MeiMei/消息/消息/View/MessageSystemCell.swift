//
//  MessageSystemCell.swift
//  PengPengApp
//
//  Created by air on 2018/11/28.
//  Copyright © 2018年 陈政宏. All rights reserved.
//

import UIKit

class MessageSystemCell: UITableViewCell {

    private var circleButton: UIButton = {
        let temp = UIButton()
        temp.backgroundColor = .white
        temp.setImage(ImageAsset.message_system.value, for: .normal)
        temp.setImage(nil, for: .normal)
        temp.isHidden = true
        temp.setCornerRadius(radius: 17.5)
        
        return temp
    }()
    
    private var line: UIView = {
        let temp = UIView()
        temp.backgroundColor = ColorAsset.ceeeeee.value
        return temp
    }()
    
    var deleteBlock:(()->())?
    
    private var messageLab: UILabel = {
        let temp = UILabel()
        temp.font = FontAsset.PingFangSC_Regular.size(.Level11)
        temp.textColor = ColorAsset.c666666.value
        temp.textAlignment = .left
        return temp
    }()
    
    private var timeLabel: UILabel = {
        let temp = UILabel()
        temp.font = FontAsset.PingFangSC_Regular.size(.Level11)
        temp.textColor = ColorAsset.c999999.value
        temp.textAlignment = .left
        return temp
    }()
    
    private var statusLabel: UILabel = {
        let temp = UILabel()
        temp.font = FontAsset.PingFangSC_Regular.size(.Level13)
        temp.textColor = ColorAsset.c333333.value
        temp.textAlignment = .left
        return temp
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initUI() {
    
        
        let backview = UIView()
        backview.backgroundColor = .white
        backview.setCornerRadius(radius: 5)
        self.contentView.addSubview(backview)
        backview.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let statusIV = UIImageView(image: ImageAsset.message_system.value)
        backview.addSubview(statusIV)
        statusIV.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.width.equalTo(44)
        }
 
        line.backgroundColor = ColorAsset.cCDCAFD.value
        backview.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(46)
            make.width.equalTo(1)
            make.left.equalTo(statusIV.snp.right).offset(15)
        }
        
  
        backview.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(line.snp.right).offset(15)
    
        }
        statusLabel.text = "系统消息"
        
        backview.addSubview(messageLab)
        messageLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(43)
            make.left.equalTo(line.snp.right).offset(15)
            make.right.equalToSuperview().offset(-40)
        }
        messageLab.text = ""
        
        backview.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-6)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        let nextImage = UIImageView(image: ImageAsset.ic_mine_go.value)
        self.contentView.addSubview(nextImage)
        nextImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-16)
            make.height.equalTo(13)
            make.width.equalTo(7)
        }
        
        self.contentView.addSubview(circleButton)
        circleButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.height.width.equalTo(35)
        }
        
        
        self.contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        
    }
    
   
    
//    func setData(_ vo :CallSystemVO){
//        self.timeLabel.text = vo.createtime ?? ""
//        self.messageLabel.text = vo.desc ?? ""
//        self.circleButton.isEnabled = vo.status == "1"
//        self.statusLabel.text = vo.title ?? ""
//
//    }
//    func setMessage(_ vo :[CallSystemVO]){
//        var isRead = true
//        for v in vo{
//            if v.status == "0" || v.status == "" {
//                isRead = false
//                break
//            }
//        }
//
//        self.statusLabel.text = "系统消息"
//        self.circleButton.isEnabled = isRead
//        statusLabel.snp.remakeConstraints({ (make) in
//            make.centerY.equalToSuperview()
//            make.left.equalTo(line.snp.right).offset(15)
//        })
//    }

}
