//
//  ViewController.swift
//  Ex_Duang
//
//  Created by zzh.
//

import UIKit
import Duang

class ViewController: UIViewController {
    
    // --------------------------------------------------------------------
    // ---- ⚠️ -  MenuConstants.ControlBarStyle == .full  -----------------
    // --------------------------------------------------------------------
    private lazy var fullMenu: Duang = {
        let menu = Duang(
            frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 100),
            subControllers: [AVC.self, BVC.self, CVC.self],
            dataSource: self,
            delegate: self,
            controlBarHeight: 54,
            loadAllCtl: false,
            style: .full)
        menu.segmentBackgroundImage = UIImage(named: "nice")
        menu.controlSpacing = 10.0
        menu.segmentHeight = 5.0
        return menu
    }()
    
    // --------------------------------------------------------------------
    // ---- ⚠️ -  MenuConstants.ControlBarStyle == .scroll  ---------------
    // --------------------------------------------------------------------
    private lazy var displayCountMenu: Duang = {
        let menu = Duang(
            frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 100),
            subControllers: [AVC.self, BVC.self, CVC.self],
            dataSource: self,
            delegate: self,
            controlBarHeight: 54,
            loadAllCtl: false,
            style: .scroll(displayCount: 2))
        menu.segmentBackgroundImage = UIImage(named: "nice")
        menu.controlSpacing = 10.0
        menu.segmentHeight = 5.0
        return menu
    }()
    
    // --------------------------------------------------------------------
    // ---- ⚠️ -  MenuConstants.ControlBarStyle == .custom  ---------------
    // --------------------------------------------------------------------
    private lazy var customMenu: Duang = {
        let menu = Duang(
            frame: CGRect(x: 0, y: 400, width: UIScreen.main.bounds.width, height: 100),
            subControllers: [AVC.self, BVC.self, CVC.self],
            dataSource: self,
            delegate: self,
            controlBarHeight: 54,
            loadAllCtl: false,
            style: .custom(itemSize: CGSize(width: 300, height: 50)))
        menu.segmentBackgroundImage = UIImage(named: "nice")
        menu.controlSpacing = 10.0
        menu.segmentHeight = 5.0
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(fullMenu)
        view.addSubview(displayCountMenu)
        view.addSubview(customMenu)
    }
    
    
}

extension ViewController: DuangDataSource {
    
    func duangControlBar(itemForIndex index: Int) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .cyan
        label.text = "No.\(index)"
        return label
    }
    
}


extension ViewController: DuangDelegate {
    func duang(initialized ctl: UIViewController) {
        print("[Duang] initialized:", ctl)
    }
    
    func duang(current ctl: UIViewController, page: Int) {
        print("[Duang] current ctl:]", ctl)
    }
    
    func duang(current item: UIView) {
        print("[Duang] current item", item)
    }
    
    func duang(didSelectControlBarAt index: Int) {
        print("[Duang] didSelectControlBarAt", index)
    }
    
    
}


