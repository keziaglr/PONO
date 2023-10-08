//
//  Activity1CurveTracingView.swift
//  TracingCharacter
//
//  Created by Mohd Arsad on 11/10/20.
//  Copyright © 2020 Mohd Arsad. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
}
public enum PanDirection: Int {
    case up, down, left, right
}

public extension CAShapeLayer{
    func createDottedPath(){
        self.strokeColor = UIColor(named: "word-color")!.cgColor
        self.lineWidth = 2
        self.lineDashPattern = [10,3]
        self.fillColor = UIColor.white.cgColor
        self.zPosition = -1
    }
    
    func createArrowPath(){
        self.strokeColor = UIColor(named: "word-color")!.cgColor
        self.lineWidth = 2
        self.fillColor = UIColor.white.cgColor
        self.zPosition = -1
    }
}

public extension UIPanGestureRecognizer {

    var direction: PanDirection? {
     let velocity = self.velocity(in: view)
     let isVertical = abs(velocity.y) > abs(velocity.x)
         if isVertical {
             return velocity.y > 0 ? .down : .up
         } else {
             return velocity.x > 0 ? .right : .left
         }
    }
}
