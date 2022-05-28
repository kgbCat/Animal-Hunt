//
//  Touch.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/17/22.
//

import Foundation
import UIKit

struct Touch {
    var color:  UIColor?
    var width: CGFloat?
    var opacity: CGFloat?
    var points: [CGPoint]?

    init(color: UIColor, points: [CGPoint]) {
        self.color = color
        self.points = points
    }
}
