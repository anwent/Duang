//
//  DuangBody.swift
//  Created by zzh.

import UIKit

public class DuangBody {
    
    private init() {}
    
    fileprivate static let instance = DuangBody()

    fileprivate var holdingControlBarItems: [UIView?] = []

    // ------------------------------------------------------------------------------------------------
    // -------⚠️ `Duang` is divided into two parts. The first part is the top control bar. ------------
    // ------------------------------------------------------------------------------------------------
    
    public class Menu: UIControl {
        
        /// page menu controllers { get }
        public var subControllers: [UIViewController.Type] {
            return _subControllers
        }
        
        public weak var menuDelegate: DuangMenuDelegate?
        
        /// Loaded controller array { get set }
        internal lazy var hasLoadControllers: [Bool] = {
            return _subControllers.map { _ in false }
        }()
        
        private var contentView: UIScrollView = UIScrollView()
        private var _subControllers: [UIViewController.Type]
        private var _loadAllCtl: Bool
        private var _preivousPage: Int = 0
        
        /// Hold viewController to prevent release
        private lazy var _holding: [UIViewController?] = {
            return _subControllers.map { _ in nil }
        }()

        init(frame: CGRect,
             subControllers: [UIViewController.Type],
             delegate: DuangMenuDelegate,
             loadAllCtl: Bool = false) {
            _subControllers = subControllers
            _loadAllCtl = loadAllCtl
            menuDelegate = delegate
            super.init(frame: frame)
            DuangBody.instance.holdingControlBarItems = _subControllers.map { _ in nil }
            createContentView()
            if _loadAllCtl {
                for i in 0..<_subControllers.count { initializeConttollerFor(controllers: i) }
            } else {
                initializeConttollerFor(controllers: 0)
            }
            if let controller = _holding[0], let view = DuangBody.instance.holdingControlBarItems[0] {
                menuDelegate?.currentControllerAfterDraggin(controller, page: 0)
                menuDelegate?.currentControlBarItemAfterDraggin(view)
            }
        }
        
        private func createContentView() {
            contentView.frame = bounds
            let ct_size = CGSize(width: bounds.width * _subControllers.count_CGFloat, height: 0)
            contentView.contentSize = ct_size
            contentView.isPagingEnabled = true
            contentView.isScrollEnabled = true
            contentView.bounces = false
            contentView.showsHorizontalScrollIndicator = false
            contentView.showsVerticalScrollIndicator = false
            contentView.delegate = self
            addSubview(contentView)
        }
        
        /// initialize ctl & add ctl.view to UIScrollView
        ///
        /// - Parameter page: current page
        private func initializeConttollerFor(controllers page: Int) {
            guard !_subControllers.isEmpty else { return }
            guard !hasLoadControllers[page] else { return }
            hasLoadControllers[page] = true
            let ctl = _subControllers[page].init()
            _holding[page] = ctl
            menuDelegate?.controllerHasInitialized(ctl)
            let x: CGFloat = CGFloat(page) * bounds.width
            let y: CGFloat = 0
            ctl.view.frame = CGRect(x: x, y: y, width: bounds.width, height: bounds.height)
            contentView.addSubview(ctl.view)
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public func menuSlide(to page: Int) {
            let point = CGPoint(x: CGFloat(page) * bounds.width, y: 0)
            UIView.animate(withDuration: 0.25) { [unowned self] in
                self.contentView.contentOffset = point
            }
        }
    }
    
    // ------------------------------------------------------------------------------------------------
    // -------⚠️ The second part is to display the contents of the sub-controller ---------------------
    // ------------------------------------------------------------------------------------------------

    public class ControlBar: UIControl {

        private let TOPSECRET = 89757
        
        public var segmentHeight: CGFloat? = 3 {
            didSet { reloadControlBar() }
        }
        
        public var segmentBackgroundColor: UIColor? = nil {
            didSet { segment.backgroundColor = segmentBackgroundColor }
        }
        
        public var segmentBackgroundImage: UIImage? = nil {
            didSet { segment.layer.contents = segmentBackgroundImage?.cgImage }
        }
        
        public var controlSpacing: CGFloat? = 5 {
            didSet { reloadControlBar() }
        }
        
        private var _style: MenuConstants.ControlBarStyle
        
        private var positioning: [CGRect] = []
        
        private lazy var segment: UIView = {
            let segment = UIView()
            return segment
        }()
        
        public weak var barDelegate: DuangControlBarDelegate?
        
        public weak var barDataSource: DuangDataSource?
        
        private lazy var contentView: UIScrollView = {
            let contentView = UIScrollView(frame: bounds)
            contentView.contentSize = CGSize(width: itemSize.width * _controllers.count_CGFloat, height: 0)
            contentView.showsHorizontalScrollIndicator = false
            contentView.showsVerticalScrollIndicator = false
            contentView.bounces = false
            return contentView
        }()
        
        private var _controllers: [UIViewController.Type]
        
        private lazy var _holdingItem: [UIView?] = {
            return _controllers.map { _ in nil }
        }()
        
        private var itemSize: CGSize {
            switch _style {
            case .full:
                return CGSize(width: bounds.width/_controllers.count_CGFloat, height: bounds.height)
            case .scroll(let displayCount):
                return CGSize(width: bounds.width/CGFloat(displayCount), height: bounds.height)
            case .custom(let itemSize):
                let h = itemSize.height > bounds.height ? bounds.height : itemSize.height
                return CGSize(width: itemSize.width, height: h)
            }
        }
        
        init(frame: CGRect,
             controllers: [UIViewController.Type],
             style: MenuConstants.ControlBarStyle = .full) {
            _style = style
            _controllers = controllers
            super.init(frame: frame)
            addSubview(contentView)
            createButtons()
        }
        
        private func createButtons() {
            for i in 0..<_controllers.count {
                let x: CGFloat = CGFloat(i) * itemSize.width + (controlSpacing ?? 0)
                let y: CGFloat = 0
                let w: CGFloat = itemSize.width - 2 * (controlSpacing ?? 0)
                let h: CGFloat = itemSize.height - (segmentHeight ?? 0)
                
                let ctl = UIControl()
                ctl.tag = TOPSECRET + i
                ctl.frame = CGRect(x: x, y: y, width: w, height: h)
                if let subview = barDataSource?.duangControlBar(itemForIndex: i) {
                    subview.frame = ctl.bounds
                    ctl.addSubview(subview)
                    DuangBody.instance.holdingControlBarItems[i] = subview
                    _holdingItem[i] = subview
                }
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.barItemSelect(_:)))
                ctl.addGestureRecognizer(tap)
                contentView.addSubview(ctl)
                positioning.append(ctl.frame)
            }
            createSegment()
        }
        
        private func createSegment() {
            segment.frame = CGRect(x: 0, y: itemSize.height - (segmentHeight ?? 0), width: positioning.first?.width ?? 0, height: segmentHeight ?? 0)
            segment.layer.masksToBounds = true
            segment.layer.cornerRadius = (segmentHeight ?? 0) / 2
            contentView.addSubview(segment)
        }
        
        public func contentSlide(_ offset: CGFloat) {
            switch _style {
            case .full:
                return
            default:
                let barScroll = contentView.contentSize.width - bounds.width
                let menuScroll = (_controllers.count_CGFloat - 1.0) * bounds.width
                let padding = offset * barScroll / menuScroll
                UIView.animate(withDuration: 0.25) { [unowned self] in
                    self.contentView.contentOffset.x = padding
                }
            }
        }
        
        public func segmentSlide(to page: Int) {
            segmentSlide(to: positioning[page])
        }
        
        private func segmentSlide(to positioning: CGRect) {
            UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [unowned self] in
                self.segment.x = positioning.minX
            })
            
        }
        
        private func reloadControlBar() {
            _ = contentView.subviews.map { $0.removeFromSuperview() }
            createButtons()
        }
        
        @objc private func barItemSelect(_ sender: UITapGestureRecognizer) {
            guard var tag = sender.view?.tag else { return }
            tag -= TOPSECRET
            segmentSlide(to: tag)
            barDelegate?.duangControlBarSelectOn(tag)
            barDelegate?.currentDuangControlBarItem(_holdingItem[tag])
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

}

extension DuangBody.Menu: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / bounds.width)
        if _preivousPage != page {
            _preivousPage = page
            initializeConttollerFor(controllers: page)
            if _holding[page] == nil {
                initializeConttollerFor(controllers: page)
            }
            if let vc = _holding[page], let item = DuangBody.instance.holdingControlBarItems[page] {
                menuDelegate?.currentControllerAfterDraggin(vc, page: page)
                menuDelegate?.currentControlBarItemAfterDraggin(item)
            }
        }
    }
    
}
