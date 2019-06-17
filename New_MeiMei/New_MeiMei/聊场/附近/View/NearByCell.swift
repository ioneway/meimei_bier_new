//
//  NearByCell.swift
//  New_MeiMei
//
//  Created by admin on 2019/6/5.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import SDWebImage

class NearByCell: UITableViewCell {

    var model: NearbyModel? {
        didSet {
            imgView.sd_setImage(with: URL.init(string: model?.avatar ?? ""))
            nameLab.text = model?.nickname
            ageTag.age = Int(model?.age ?? "0") ?? 0
            locationBtn.setTitle("\(model?.distance ?? 50)米以内", for: .normal)
            infoLab.text = model?.signature
            
        }
    }
    
    let imgView: UIImageView = {
        let temp = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 48, height: 48))
        temp.clipsToBounds = true
        temp.layer.cornerRadius = 24
        return temp
    }()
    
    let nameLab: UILabel = {
        let temp = UILabel()
        temp.font = FontAsset.PingFangSC_Regular.size(.Level14)
        temp.textColor = ColorAsset.c666666.value
        temp.textAlignment = .left
        temp.text = "风的味道"
        return temp
    }()

    let ageTag: AgeTagView = {
        let temp = AgeTagView()
        temp.gender = false
        temp.age = 20
        return temp
    }()
    
    let locationBtn: UIButton = {
        let temp = UIButton()
        temp.setImage(ImageAsset.ic_location.value, for: .normal)
        temp.setTitle("500米以内", for: .normal)
        temp.setTitleColor(ColorAsset.c999999.value, for: .normal)
        temp.titleLabel?.font = FontAsset.PingFangSC_Regular.size(.Level10)
        temp.aligmentAndSpace = (alignment: .left, space: 7.0)
        return temp
    }()
    
    let infoLab: UILabel = {
        let temp = UILabel()
        temp.text = "我相信爱笑的女孩，运气不…"
        temp.textColor = ColorAsset.c999999.value
        temp.font = FontAsset.PingFangSC_Regular.size(.Level12)
        temp.lineBreakMode = .byTruncatingTail
        return temp
    }()
    
    let hiBtn: UIButton = {
        let temp = UIButton()
        temp.setImage(ImageAsset.ic_hi_select.value, for: .normal)
        return temp
    }()
    
    let liaoBtn: UIButton = {
        let temp = UIButton()
        temp.setImage(ImageAsset.ic_liao_select.value, for: .normal)
        return temp
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        _setupUI()
    }
    
    func _setupUI() {
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(nameLab)
        self.contentView.addSubview(infoLab)
        self.contentView.addSubview(ageTag)
        self.contentView.addSubview(locationBtn)
        self.contentView.addSubview(hiBtn)
        self.contentView.addSubview(liaoBtn)
        
        _cons()
    }
    
    func _cons() {
        self.imgView.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.height.width.equalTo(48)
            make.top.equalTo(11)
        }
        
        self.nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(16)
            make.height.equalTo(20)
            make.top.equalTo(8)
        }
        
        self.ageTag.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab.snp.left)
            make.height.equalTo(15)
            make.width.equalTo(43)
            make.top.equalTo(nameLab.snp.bottom).offset(4)
        }
        
        self.infoLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab.snp.left)
            make.height.equalTo(20)
            make.width.equalTo(160)
            make.top.equalTo(ageTag.snp.bottom).offset(4)
        }
        
        self.locationBtn.snp.makeConstraints { (make) in
            make.left.equalTo(ageTag.snp.right).offset(10)
            make.centerY.equalTo(ageTag)
        }
        
        self.hiBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(32)
            make.height.equalTo(29)
            make.right.equalTo(-63)
        }
        
        self.liaoBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(32)
            make.height.equalTo(29)
            make.right.equalTo(-16)
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
