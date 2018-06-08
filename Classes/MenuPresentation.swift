//
//  MenuPresentation.swift
//  Created by zzh.

import UIKit

public protocol DuangDataSource: class {
    
    /// emmmmm, just like UITableViewCell....
    ///
    /// - Parameter index: Just index
    /// - Returns: Displayed view
    func duangControlBar(itemForIndex index: Int) -> UIView
}

public protocol DuangDelegate: class {
    
    /// Called when the controller completes initialization in PageMenu's subController
    ///
    /// - Parameter ctl: Just controller
    func duang(initialized ctl: UIViewController)

    /// current viewController
    ///
    /// - Parameters:
    ///   - ctl: viewController, you can: `ctl as? SomeViewController`
    ///   - page: Just page
    func duang(current ctl: UIViewController, page: Int)
    
    /// current controlBar item
    ///
    /// - Parameter item: controlBar item, you can: `item as? UILabel`
    func duang(current item: UIView)

    /// Select controlBar item
    ///
    /// - Parameter index: Just index
    func duang(didSelectControlBarAt index: Int)

}


// ------------------------------------------------------------------------------------------------
// -------⚠️ The following part is used in the `DuangBody` layer, so similar to above--------------
// ------------------------------------------------------------------------------------------------

public protocol DuangMenuDelegate: class {
    func controllerHasInitialized(_ ctl: UIViewController)
    func currentControllerAfterDraggin(_ ctl: UIViewController, page: Int)
    func currentControlBarItemAfterDraggin(_ item: UIView?)
}

public protocol DuangControlBarDelegate: class {
    func duangControlBarSelectOn(_ page: Int)
    func currentDuangControlBarItem(_ item: UIView?)
}

public protocol DuangPresentation {
    var segmentHeight: CGFloat? { get set }
    var controlSpacing: CGFloat? { get set }
    var segmentBackgroundColor: UIColor? { get set }
    var segmentBackgroundImage: UIImage? { get set }
}




