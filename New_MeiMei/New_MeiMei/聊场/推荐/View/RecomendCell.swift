//
//  RecomendCell.swift
//  New_MeiMei
//
//  Created by admin on 2019/6/10.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class RecomendCell: UICollectionViewCell {
    
    var recomendModel: RecomendModel? {
        didSet {
            imgView.sd_setImage(with: URL.init(string: recomendModel?.avatar ?? ""))
            titleLab.text = recomendModel?.nickname ?? ""
            priceLab.text = "\(recomendModel?.amount ?? 0)MM币"
        }
    }
    
    let titleLab: UILabel = {
        let temp = UILabel()
        temp.textColor = .white
        temp.text = ""
        temp.textAlignment = .left
        temp.font = FontAsset.PingFangSC_Regular.size(.Level12)
        return temp
    }()
    
    let priceLab: UILabel = {
        let temp = UILabel()
        temp.textColor = .white
        temp.text = ""
        temp.textAlignment = .left
        temp.font = FontAsset.PingFangSC_Regular.size(.Level12)
        return temp
    }()
    
    let imgView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage()
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        
        imgView.contentMode = .scaleAspectFill
        imgView.setCornerRadius(radius: 8)
        self.contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let backV: UIView = {
            let temp = UIView()
            temp.backgroundColor  = .black
            temp.alpha = 0.3
            return temp
        }()
        contentView.addSubview(backV)
        backV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(imgView.snp.bottom)
            make.height.equalTo(31)
        }
        
        contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(imgView.snp.bottom).offset(-8)
            make.left.equalToSuperview().offset(5)
        }
        
        contentView.addSubview(priceLab)
        priceLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLab)
            make.right.equalToSuperview().offset(-3)
        }
        
        let icoVideo = UIImageView.init(image: ImageAsset.ic_video.value)
        contentView.addSubview(icoVideo)
        icoVideo.snp.makeConstraints { (make) in
            make.centerY.equalTo(priceLab).offset(0)
            make.size.equalTo(CGSize(width: 18, height: 10))
            make.right.equalTo(priceLab.snp.left).offset(5)
        }
    }
    
}
