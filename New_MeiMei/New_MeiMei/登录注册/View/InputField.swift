//
//  InputField.swift
//  newToken_swift
//
//  Created by 王伟 on 2018/12/28.
//  Copyright © 2018 王伟. All rights reserved.
//

import UIKit


@objc protocol InputFieldDelegate {
    @objc  optional func textFieldDidEndEditing(_ textField: InputField)
    @objc  optional func textFieldDidBeginEditing(_ textField: InputField)
}

class InputField: UIView, UITextFieldDelegate{
    
    private var _field: UITextField = {
        let temp = UITextField()

        return temp
    }()
    
    private var _line: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.white
        return temp
    }()
    
    public var rightView: UIView? {
        didSet {
            self._field.rightView = rightView
            self._field.rightViewMode = .always
        }
    }
    
    public var delegate: InputFieldDelegate?
    
    public var rightText: String? {
        didSet {
            let label = UILabel()
            label.text = rightText
            label.width = label.width + 30
            _field.leftView = label
            _field.leftViewMode = .always
        }
    }
    
    public var leftText: String? {
        didSet {
            if (_field.leftView == nil) {
                let label = UILabel()
                label.text = leftText
                label.sizeToFit()
                label.width = label.width + 20
                _field.leftView = label
                _field.leftViewMode = .always
            }
        }
    }
    
    public var isSecureTextEntry: Bool {
        didSet {
            _field.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    public var leftImg: UIImage? {
        didSet {
            if (_field.leftView == nil) {
                let imgv = UIImageView.init(image: leftImg)
                imgv.width = imgv.width + 30
                imgv.contentMode = .center
                _field.leftView = imgv
                _field.leftViewMode = .always
            }
        }
    }
    
    public var placeHolder: String? {
        didSet {
            _field.placeholder = placeHolder
        }
    }
    public var text: String? {

        get {
            return _field.text
        }
        
        set {
            _field.text = text
        }
    }
    public var placeHolderColor: UIColor? = ColorAsset.c999999.value {
        didSet {
            _field.setValue(placeHolderColor, forKey: "_placeholderLabel.textColor")
        }
    }
    
    public var font: UIFont = FontAsset.PingFangSC_Regular.size(.Level16) {
        didSet {
            _field.font = font
        }
    }
    
    public var placeHolederFont: UIFont = FontAsset.PingFangSC_Regular.size(.Level15) {
        didSet {
            
            _field.setValue(placeHolederFont, forKey: "_placeholderLabel.font")
        }
    }
    
    
    override init(frame: CGRect) {
        self.isSecureTextEntry = false
        super.init(frame: frame)
        self.rightView = nil
        self.leftImg = nil
        self.leftText = nil
        self.rightText = nil
        self.backgroundColor = .white
        _field.delegate = self;
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField)
    {
        if let delegate = self.delegate {
            delegate.textFieldDidBeginEditing?(self)
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if let delegate = self.delegate {
            delegate.textFieldDidBeginEditing?(self)
        }
    }
    
    private func setupUI()
    {
        self.addSubview(_field)
        self.addSubview(_line)
        constraints()
    }
    
    private func constraints()
    {
        _line.snp.makeConstraints{ (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
        
        _field.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.right.equalToSuperview()
        }
    }
}

