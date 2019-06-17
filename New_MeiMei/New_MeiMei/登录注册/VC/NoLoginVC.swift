//
//  NoLoginVC.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/24.
//  Copyright © 2019 admin. All rights reserved.
//  未登录界面

import UIKit

class NoLoginVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar?.hide = true
    }

    @IBAction func loginBtnClick(_ sender: Any) {
        self.navigationController?.pushViewController(LoginVC(), animated: true)
    }
}
