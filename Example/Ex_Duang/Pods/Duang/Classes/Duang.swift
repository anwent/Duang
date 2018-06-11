//
//  Duang.swift
//  Created by zzh.
//
//          ·--------------------------------------·
//          | _______  _______   _______   _______ |
//          | |item1|  |item2|   |item3|   |item4| |  <--------- controlBar
//          | -------  -------   -------   ------- |
//          | =======                              |
//          ·--------------------------------------·
//          |                                      |
//          |                                      |
//          |                                      |
//          |                                      |
//          |                                      |  <--------- Menu
//          |                                      |
//          |                                      |
//          |                                      |
//          |                                      |
//          |                                      |
//          ·--------------------------------------·
//

import UIKit

public class Duang: UIControl, DuangPresentation {
    
    /// Just menu
    private var menu: DuangBody.Menu?
    
    /// Just controlBar
    private var controlBar: DuangBody.ControlBar?
    
    /// Segment line background color, default is nil
    public var segmentBackgroundColor: UIColor? {
        get { return controlBar?.segmentBackgroundColor }
        set { controlBar?.segmentBackgroundColor = newValue }
    }
    
    /// Segment line background image, defalut is nil
    public var segmentBackgroundImage: UIImage? {
        get { return controlBar?.segmentBackgroundImage }
        set { controlBar?.segmentBackgroundImage = newValue }
    }
    
    /// Segment line height, default is 3
    public var segmentHeight: CGFloat? {
        get { return controlBar?.segmentHeight }
        set { controlBar?.segmentHeight = newValue }
    }
    
    /// Pagemenu the spacing between buttons on the control bar, default is 5
    public var controlSpacing: CGFloat? {
        get { return controlBar?.controlSpacing }
        set { controlBar?.controlSpacing = newValue }
    }
    
    private weak var dDelegate: DuangDelegate?
    
    /// Initialization
    ///
    /// - Parameters:
    ///   - frame: Just frame
    ///   - subControllers: All controllers
    ///   - dataSource: DuangDataSource
    ///   - delegate: DuangDelegate
    ///   - controlBarHeight: ControlBar height, defalut is 44
    ///   - loadAllCtl: Whether to initialize all controllers directly, default is false
    ///   - style: Control bar style, detailed see github
    public init(frame: CGRect,
                subControllers: [UIViewController.Type],
                dataSource: DuangDataSource? = nil,
                delegate: DuangDelegate? = nil,
                controlBarHeight: CGFloat = 44,
                loadAllCtl: Bool = false,
                style: MenuConstants.ControlBarStyle = .full) {
        dDelegate = delegate
        super.init(frame: frame)
        
        controlBar = DuangBody.ControlBar(frame: CGRect(x: 0, y: 0, width: bounds.width, height: controlBarHeight), controllers: subControllers, style: style)
        controlBar?.barDelegate = self
        controlBar?.barDataSource = dataSource
        
        menu = DuangBody.Menu(frame: CGRect(x: 0, y: controlBarHeight, width: bounds.width, height: bounds.height - controlBarHeight), subControllers: subControllers, delegate: self, loadAllCtl: loadAllCtl)
        
        addSubview(controlBar!)
        addSubview(menu!)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Duang: DuangMenuDelegate {
    public func currentControlBarItemAfterDraggin(_ item: UIView?) {
        guard let view = item else { return }
        dDelegate?.duang(current: view)
    }
    
    
    public func controllerHasInitialized(_ ctl: UIViewController) {
        dDelegate?.duang(initialized: ctl)
    }
    
    public func currentControllerAfterDraggin(_ ctl: UIViewController, page: Int) {
        controlBar?.segmentSlide(to: page)
        controlBar?.contentSlide(CGFloat(page)*bounds.width)
        dDelegate?.duang(current: ctl, page: page)
    }
}

extension Duang: DuangControlBarDelegate {
    public func currentDuangControlBarItem(_ item: UIView?) {
        guard let view = item else { return }
        dDelegate?.duang(current: view)
    }
    
    public func duangControlBarSelectOn(_ page: Int) {
        menu?.menuSlide(to: page)
        dDelegate?.duang(didSelectControlBarAt: page)
    }
}
