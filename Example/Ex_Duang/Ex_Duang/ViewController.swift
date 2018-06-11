//
//  ViewController.swift
//  Ex_Duang
//
//  Created by zzh on 2018/6/11.
//  Copyright © 2018年 wow250250. All rights reserved.
//

import UIKit
import Duang

class ViewController: UIViewController {

    private lazy var menu: Duang = {
        let menu = Duang(
            frame: UIScreen.main.bounds,
            subControllers: [AVC.self, BVC.self, CVC.self],
            dataSource: self,
            delegate: self,
            controlBarHeight: 60,
            loadAllCtl: false,
            style: .full)
        return menu
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(menu)
    }


}

extension ViewController: DuangDataSource {

    func duangControlBar(itemForIndex index: Int) -> UIView {
        <#code#>
    }
    
    
//    func duangControlBar(itemForIndex index: Int) -> UIView {
//        let label = UILabel()
//        label.textColor = .cyan
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.text = "No.\(index)"
//        label.textAlignment = .center
//        return label
//    }
    
}


extension ViewController: DuangDelegate {
    func duang(initialized ctl: UIViewController) {
        print("[Duang] initialized:", ctl)
    }
    
    func duang(current ctl: UIViewController, page: Int) {
        print("[Duang] current ctl:]", ctl)
    }
    
    func duang(current item: UIView) {
        print("[Duang] current item:", item)
    }
    
    func duang(didSelectControlBarAt index: Int) {
        print("[Duang] didSelectControlBarAt", index)
    }
    
    
}


