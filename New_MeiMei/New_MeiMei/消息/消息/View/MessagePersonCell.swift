//
//  MessagePersonCell.swift
//  PengPengApp
//
//  Created by air on 2018/11/28.
//  Copyright © 2018年 陈政宏. All rights reserved.
//

import UIKit

class MessagePersonCell: UITableViewCell {

    
    fileprivate var headIV = UIImageView()
    
    
    private var nameLab: UILabel = {
        let temp = UILabel()
        temp.font = FontAsset.PingFangSC_Regular.size(.Level16)
        temp.textColor = ColorAsset.c333333.value
        temp.textAlignment = .left
        return temp
    }()
    
    private var messageLab: UILabel = {
        let temp = UILabel()
        temp.font = FontAsset.PingFangSC_Regular.size(.Level14)
        temp.textColor = ColorAsset.c666666.value
        temp.textAlignment = .left
        return temp
    }()
    
    private var numberLab: UILabel = {
        let temp = UILabel()
        temp.font = FontAsset.PingFangSC_Regular.size(.Level10)
        temp.textColor = ColorAsset.c666666.value
        temp.textAlignment = .left
        return temp
    }()
    
    private var timeLab: UILabel = {
        let temp = UILabel()
        temp.font = FontAsset.PingFangSC_Regular.size(.Level11)
        temp.textColor = ColorAsset.c666666.value
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
    fileprivate func initUI(){
//        let bg = UIImageView(image: R.image.icon_taleplace_cellBG())
       
        
        contentView.addSubview(headIV)
        headIV.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.width.equalTo(36)
        }
        headIV.setCornerRadius(radius:18)
    
        
        contentView.addSubview(nameLab)
        nameLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(headIV.snp.centerY).offset(0)
            make.left.equalTo(headIV.snp.right).offset(15)
            
        }

        
        contentView.addSubview(messageLab)
        messageLab.snp.makeConstraints { (make) in
            make.top.equalTo(headIV.snp.centerY).offset(3)
            make.left.equalTo(headIV.snp.right).offset(15)
            make.right.equalToSuperview().offset(-40)
        }
        messageLab.text = "消息消息消息消息消息消息消息消息消息消息消息消息"
        
        contentView.addSubview(timeLab)
        timeLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-13)
            make.top.equalToSuperview().offset( 7)
        }
        
        contentView.addSubview(numberLab)
        numberLab.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-13)
            make.height.width.equalTo(11)
        }
        numberLab.setCornerRadius(radius: 5.5)
        numberLab.backgroundColor = .red
        
        let linView = UIView()
        linView.backgroundColor = ColorAsset.ceeeeee.value
        contentView.addSubview(linView)
        linView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }


    }

    func setData(_ recent : NIMRecentSession){
//        self.nameLabel.text = NIMKitHelper.nameForRecentSession(session: recent.session ?? NIMSession())
//
//        self.timeLabel.text = NIMKitHelper.timestampDescriptionForRecentSession(recent: recent)
//        self.headIV.setAvatarBySession(recent.session ?? NIMSession())
// 
//        self.numberLabel.isHidden = recent.unreadCount == 0 ? true : false
//        self.numberLabel.text = "\(recent.unreadCount)"
    }
}
