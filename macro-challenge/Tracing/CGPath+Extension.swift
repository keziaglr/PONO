//
//  CGPath+Extension.swift
//  TracingCharacter
//
//  Created by Mohd Arsad on 11/10/20.
//  Copyright © 2020 Mohd Arsad. All rights reserved.
//

import Foundation
import UIKit


extension CGPath {
    
    /*
     Generate all element type of your cgPath and
     calculate all point of every element type, Its provide the
     final count of adjucent points.
     */
    func getPathElementsPoints() -> [CGPoint] {
        var arrayPoints : [CGPoint]! = [CGPoint]()
        var lastPoint: CGPoint = .zero
        self.forEach { element in
            switch (element.type) {
            case CGPathElementType.moveToPoint:
                let p0 = element.points[0]
                lastPoint = p0
            case .addLineToPoint:
                let p0 = element.points[0]
                let tPoints = self.getPointsForLineCurve(p0: lastPoint, p1: p0)
                arrayPoints += tPoints
                lastPoint = p0
            case .addQuadCurveToPoint:
                let p0 = element.points[0]
                let p1 = element.points[1]
                let tPoints = self.getPointForQuadCurve(p0: lastPoint, p1: p1, pc1: p0)
                arrayPoints += tPoints
                lastPoint = p1
            case .addCurveToPoint:
                let p0 = element.points[0]
                let p1 = element.points[1]
                let p2 = element.points[2]
                let tPoints = self.getPointForCurve(p0: lastPoint, p1: p2, pc1: p0, pc2: p1)
                arrayPoints += tPoints
                lastPoint = p2
            default: break
            }
        }
        return arrayPoints
    }
    
    private func forEach( body: @escaping @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        let callback: @convention(c) (UnsafeMutableRawPointer, UnsafePointer<CGPathElement>) -> Void = { (info, element) in
            let body = unsafeBitCast(info, to: Body.self)
            body(element.pointee)
        }
        //print(MemoryLayout.size(ofValue: body))
        let unsafeBody = unsafeBitCast(body, to: UnsafeMutableRawPointer.self)
        self.apply(info: unsafeBody, function: unsafeBitCast(callback, to: CGPathApplierFunction.self))
    }
    
    /*
     Get cubic curve all points which handled by 4 points
     2 had for start, end and 2 for the
     control of curve
     */
    private func getPointForCurve(p0: CGPoint, p1: CGPoint, pc1: CGPoint, pc2: CGPoint) -> [CGPoint] {
        
        let distance0 = p0.distance(to: p1)
        let distance1 = p0.distance(to: pc1)
        let distance2 = p0.distance(to: pc2)
        
        let distance3 = p1.distance(to: pc1)
        let distance4 = p1.distance(to: pc2)
        
        let distance5 = pc1.distance(to: pc2)
        
        let highestDistance = [distance0, distance1, distance2, distance3, distance4, distance5].sorted().reversed().first ?? 100.0
//        print("CG Curve Distance0: \(distance0),Distance1: \(distance1),Distance2: \(distance2),Distance3: \(distance3),Distance4: \(distance4),Distance5: \(distance5), Highest: \(highestDistance)")
        
        let intervalPoints = getIntervalPoints(count: highestDistance)
        var pointsArr: [CGPoint] = []
        
        for iPoints in intervalPoints {
            let point = self.cubicCurveFormula(u: iPoints, p0: p0, p1: p1, pc1: pc1, pc2: pc2)
            pointsArr.append(point)
        }
        return pointsArr
    }
    
    /*
     Get all points which have 3 points
     2 points start end and 1 control point.
     */
    private func getPointForQuadCurve(p0: CGPoint, p1: CGPoint, pc1: CGPoint) -> [CGPoint] {
        
        let distance0 = p0.distance(to: pc1)
        let distance1 = pc1.distance(to: p1)
        let distance2 = p0.distance(to: p1)
        
        let highestDistance = [distance0, distance1, distance2].sorted().reversed().first ?? 100.0
//        print("CG Quad Distance0: \(distance0),Distance1: \(distance1),Distance2: \(distance2), Highest: \(highestDistance)")
        
        let intervalPoints = getIntervalPoints(count: highestDistance)
        var pointsArr: [CGPoint] = []
        
        for iPoints in intervalPoints {
            let point = self.quadCurveFormula(u: iPoints, p0: p0, p1: p1, pc1: pc1)
            pointsArr.append(point)
        }
        return pointsArr
    }
    
    /*
     Get all points of a line between two points.
     */
    private func getPointsForLineCurve(p0: CGPoint, p1: CGPoint) -> [CGPoint] {
        let distance0 = p0.distance(to: p1)
//        print("CG Line Distance0: \(distance0)")
        let intervalPoints = getIntervalPoints(count: distance0 / 1.5) //70.0
        var pointsArr: [CGPoint] = []
        
        for iPoints in intervalPoints {
            pointsArr.append(self.lineFormula(u: iPoints, p0: p0, p1: p1))
        }
        return pointsArr
    }
    
    /*
     Create interval ratio for ulternate points
     (Point gap): 0 << count << 1
     */
    private func getIntervalPoints(count: CGFloat) -> [CGFloat] {
        var totalCount: CGFloat = count
        if count < 1 {
            totalCount = 1
        }
        var intervalPoints: [CGFloat] = []
        let totalLengthWant: CGFloat = totalCount - 1.0
        let intervalRatio: CGFloat = 1.0/totalLengthWant //Always work between 0 to 1
        for index in 0..<Int(totalLengthWant) {
            if index == 0 {
                intervalPoints.append(0.0)
            } else {
                let point = CGFloat(intervalRatio * CGFloat(index))
                intervalPoints.append(point)
            }
        }
        intervalPoints.append(1.0)
        return intervalPoints
    }
    
    /*
     All formula for handle teh different type of curve,
     Its generate the new upcoming X coordinate and new Y coordinate.
     
     These furmula work on basis of BLENDING BESIC FULRMULA
     */
    private func cubicCurveFormula(u: CGFloat, p0: CGPoint, p1: CGPoint, pc1: CGPoint, pc2: CGPoint) -> CGPoint {
        let uP = (1-u)
        func getPoint(pt0: CGFloat, pt1: CGFloat, pct1: CGFloat, pct2: CGFloat) -> CGFloat {
            let p = (pt0 * (uP*uP*uP)) + (pct1 * 3 * u * (uP*uP)) + (pct2 * 3 * (u * u) * uP) + (pt1 * (u*u*u))
            return p
        }
        let point = CGPoint(x: getPoint(pt0: p0.x, pt1: p1.x, pct1: pc1.x, pct2: pc2.x), y: getPoint(pt0: p0.y, pt1: p1.y, pct1: pc1.y, pct2: pc2.y))
        return point
    }
    
    private func quadCurveFormula(u: CGFloat, p0: CGPoint, p1: CGPoint, pc1: CGPoint) -> CGPoint {
        let uP = (1-u)
        func getPoint(pt0: CGFloat, pt1: CGFloat, pct1: CGFloat) -> CGFloat {
            let p = (pt0 * (uP*uP)) + (pct1 * 2 * u * uP) + (pt1 * (u*u))
            return p
        }
        let point = CGPoint(x: getPoint(pt0: p0.x, pt1: p1.x, pct1: pc1.x), y: getPoint(pt0: p0.y, pt1: p1.y, pct1: pc1.y))
        return point
    }
    
    private func lineFormula(u: CGFloat, p0: CGPoint, p1: CGPoint) -> CGPoint {
        let uP = (1-u)
        func getPoint(pt0: CGFloat, pt1: CGFloat) -> CGFloat {
            let p = (pt0 * uP) + (pt1 * u)
            return p
        }
        let point = CGPoint(x: getPoint(pt0: p0.x, pt1: p1.x), y: getPoint(pt0: p0.y, pt1: p1.y))
        return point
    }
}

extension CGPoint {
    func angle(between point: CGPoint) -> CGFloat {
        let center = CGPoint(x: point.x - self.x, y: point.y - self.y)
        let radians = atan2(center.y, center.x)
        let degrees = radians * 180 / .pi
        return degrees > 0 ? degrees : degrees + degrees
    }
    
    func angleRadian(between point: CGPoint) -> CGFloat {
        let center = CGPoint(x: point.x - self.x, y: point.y - self.y)
        let radians = atan2(center.y, center.x)
        return radians
//        let degrees = radians * 180 / .pi
//        return degrees > 0 ? degrees : degrees + degrees
    }
}

extension UIBezierPath {
    func addArrow(start: CGPoint, end: CGPoint, pointerLineLength: CGFloat, arrowAngle: CGFloat) {
        let startEndAngle = atan((end.y - start.y) / (end.x - start.x)) + ((end.x - start.x) < 0 ? CGFloat(Double.pi) : 0)
        let arrowLine1 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle + arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle + arrowAngle))
        let arrowLine2 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle - arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle - arrowAngle))
        
        self.move(to: arrowLine1)
        self.addLine(to: end)
        self.addLine(to: arrowLine2)
    }
}
