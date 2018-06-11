//
//  MenuConstants.swift
//  Created by zzh.

import UIKit

public class MenuConstants {
    
    public enum ControlBarStyle {
        case full
        case scroll(displayCount: Int)
        case custom(itemSize: CGSize)
    }
}

extension Array {
    var count_CGFloat: CGFloat {
        return CGFloat(count)
    }
}

extension UIView {
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
}
