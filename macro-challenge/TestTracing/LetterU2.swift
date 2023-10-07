//
//  LetterB.swift
//  TestTracing
//
//  Created by Kezia Gloria on 05/10/23.
//

import Foundation
import UIKit

class LetterU2: UIView {
    
    var dottedLayer = CAShapeLayer()
    private var curveLayer = CAShapeLayer()
    private var borderLayer = CAShapeLayer()
    
    //Color
    private var curveBackgroundColor = UIColor.white
    private var curveFillColor = UIColor(red: 25/255.0, green: 168/255.0, blue: 243/255.0, alpha: 1.0)
    private var lastPoint: CGPoint = .zero
    
    var progress: CGFloat? {
        didSet {
            self.createRatioCurve()
        }
    }
    var touchPoint: CGPoint = .zero {
        didSet {
            self.createRatioCurve()
        }
    }
    var curveMainPath: UIBezierPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        self.backgroundColor = curveBackgroundColor
        self.createCurveForTracing()
        self.createDottedLine()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createRatioCurve() {
        
        let startPoint = lastPoint
        self.updateNavigationPath(start: startPoint, end: touchPoint)
        lastPoint = touchPoint
        
    }
}

private extension LetterU2 {
    
    func createCurveForTracing() {
        let quarterRatio = self.bounds.width * 0.25
        let width = self.bounds.width
        let height = self.bounds.height
        let curvePath = UIBezierPath()

        curvePath.move(to: CGPoint(x: -quarterRatio, y: height))
        curvePath.addLine(to: CGPoint(x: width, y: height))
        curvePath.addLine(to: CGPoint(x: width, y: quarterRatio))
        curvePath.addLine(to: CGPoint(x: -quarterRatio, y: quarterRatio))
        curvePath.close()
        self.curveMainPath = curvePath

        curveLayer = CAShapeLayer()
        curveLayer.path = curvePath.cgPath
        curveLayer.fillColor = curveBackgroundColor.cgColor
        curveLayer.strokeColor = UIColor.red.cgColor
        curveLayer.lineWidth = 5.0
        self.layer.mask = curveLayer
        
//                curvePath.move(to: CGPoint(x: -quarterRatio, y: height))
//                curvePath.addLine(to: CGPoint(x: width, y: height))
//                curvePath.addLine(to: CGPoint(x: width, y: quarterRatio))
//                curvePath.addLine(to: CGPoint(x: -quarterRatio, y: quarterRatio))
//                curvePath.close()
//                self.curveMainPath = curvePath
//
//                curveLayer = CAShapeLayer()
//                curveLayer.path = curvePath.cgPath
//                curveLayer.fillColor = curveBackgroundColor.cgColor
//                curveLayer.strokeColor = UIColor.red.cgColor
//                curveLayer.lineWidth = 5.0
//                self.layer.mask = curveLayer
        
//        let textLayer = CATextLayer()
//        textLayer.string = "u"
//        textLayer.font = UIFont(name: "Quicksand-Bold", size: 250)
//        textLayer.fontSize = CGFloat(self.bounds.height)
//        textLayer.alignmentMode = .center
//        textLayer.bounds = self.bounds
//        textLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
//        self.layer.mask = textLayer
    }
    
    private func createDottedLine() {
        let quarterRatio = self.bounds.width * 0.25

        dottedLayer = CAShapeLayer()
        dottedLayer.strokeColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        dottedLayer.lineWidth = 2
        dottedLayer.lineDashPattern = [10,3]
        dottedLayer.fillColor = UIColor.white.cgColor
        let cgPath = CGMutablePath()
        
        
        //MARK: U
        let p0 = CGPoint(x: quarterRatio * 2.7, y: quarterRatio * 0.5)
        let p1 = CGPoint(x: quarterRatio * 3.3, y: quarterRatio * 3.2)
        let p2 = CGPoint(x: quarterRatio * 1.5, y: quarterRatio * 3.3)
        let p3 = CGPoint(x: quarterRatio * 1.0, y: quarterRatio * 2)
        let p4 = CGPoint(x: quarterRatio * 0.4, y: quarterRatio * 3.25)

        cgPath.move(to: p0)
        cgPath.addLine(to: p1)
        cgPath.addLine(to: p2)
        cgPath.addQuadCurve(to: p3, control: p4)

        cgPath.closeSubpath()
        dottedLayer.path = cgPath
        self.layer.insertSublayer(dottedLayer, below: borderLayer)
    }
    
    
    private func updateNavigationPath(start: CGPoint, end: CGPoint) {
        let layerT = drawLineFromPoint(start: start, toPoint: end, ofColor: .green, lineWidth: 35)
        self.layer.insertSublayer(layerT, below: borderLayer)
    }

    private func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, lineWidth: CGFloat) -> CAShapeLayer {

        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .round
        return shapeLayer
    }
    
    
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }

    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
}

//private extension LetterB {
//
//    func createCurveForTracing() {
//        let quarterRatio = self.bounds.width * 0.25
//        let width = self.bounds.width
//        let height = self.bounds.height
//        let curvePath = UIBezierPath()
//
//        curvePath.move(to: CGPoint(x: -quarterRatio, y: height))
//        curvePath.addLine(to: CGPoint(x: width, y: height))
//        curvePath.addLine(to: CGPoint(x: width, y: quarterRatio))
//        curvePath.addLine(to: CGPoint(x: -quarterRatio, y: quarterRatio))
//        curvePath.close()
//        self.curveMainPath = curvePath
//
//        curveLayer = CAShapeLayer()
//        curveLayer.path = curvePath.cgPath
//        curveLayer.fillColor = curveBackgroundColor.cgColor
//        curveLayer.strokeColor = UIColor.red.cgColor
//        curveLayer.lineWidth = 5.0
//        self.layer.mask = curveLayer
////
////        borderLayer = CAShapeLayer()
////        borderLayer.path = textLayer.accessibilityPath?.cgPath
////        borderLayer.fillColor = UIColor.clear.cgColor
////        borderLayer.strokeColor = UIColor.white.cgColor
////        borderLayer.lineWidth = 6.0
////        self.layer.addSublayer(borderLayer)
////        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
//////        containerView.center = view.center
////        self.layer.addSubview(containerView)
//
//        // Create a text layer with the text you want to mask
//        let textLayer = CATextLayer()
//        textLayer.string = "g"
//        textLayer.font = UIFont(name: "Quicksand-Bold", size: 250)
////        textLayer.fontSize = CGFloat(200)
//        textLayer.fontSize = CGFloat(self.bounds.height)
//        textLayer.alignmentMode = .center
//        textLayer.bounds = self.bounds //CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height * 1.5) //self.bounds // Use the same size as the container view
//        textLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
//        self.layer.mask = textLayer
////
////        // Create a border layer around the text
////        borderLayer = CAShapeLayer()
////        borderLayer.path = UIBezierPath(rect: self.bounds).cgPath
////        borderLayer.fillColor = UIColor.clear.cgColor
////        borderLayer.strokeColor = UIColor.white.cgColor
////        borderLayer.lineWidth = 6.0
//
//        // Add the border layer to the container view's layer
////        self.layer.addSublayer(borderLayer)
//    }
//
//    private func createDottedLine() {
//        let quarterRatio = self.bounds.width * 0.25
//
//        dottedLayer = CAShapeLayer()
//        dottedLayer.strokeColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
//        dottedLayer.lineWidth = 2
//        dottedLayer.lineDashPattern = [10,3]
//        dottedLayer.fillColor = UIColor.white.cgColor
//        let cgPath = CGMutablePath()
//
//
//        //MARK: U
////        let p0 = CGPoint(x: quarterRatio * 2.7, y: quarterRatio * 0.5)
////        let p1 = CGPoint(x: quarterRatio * 3.3, y: quarterRatio * 3.2)
////        let p2 = CGPoint(x: quarterRatio * 1.5, y: quarterRatio * 3.3)
////        let p3 = CGPoint(x: quarterRatio * 1.0, y: quarterRatio * 2)
////        let p4 = CGPoint(x: quarterRatio * 0.4, y: quarterRatio * 3.25)
////
////        cgPath.move(to: p0)
////        cgPath.addLine(to: p1)
////        cgPath.addLine(to: p2)
////        cgPath.addQuadCurve(to: p3, control: p4)
//
//        let p0 = CGPoint(x: quarterRatio * 1.2, y: quarterRatio)
//        let p1 = CGPoint(x: quarterRatio * 1.2, y: quarterRatio * 4)
//        let p2 = CGPoint(x: quarterRatio * 1.2, y: quarterRatio * 2)
//        let p3 = CGPoint(x: quarterRatio * 1.2, y: quarterRatio * 4)
//
//        cgPath.move(to: p0)
//        cgPath.addLine(to: p1)
//        cgPath.closeSubpath()
//        cgPath.move(to: p2)
//        cgPath.addCurve(to: p3, control1: CGPoint(x: quarterRatio * 3.5, y: quarterRatio * 2), control2: CGPoint(x: quarterRatio * 3.5, y: quarterRatio * 4))
////        cgPath.addLine(to: p3)
//
//        cgPath.closeSubpath()
//        dottedLayer.path = cgPath
//        self.layer.insertSublayer(dottedLayer, below: borderLayer)
//    }
//
//
//    private func updateNavigationPath(start: CGPoint, end: CGPoint) {
//        let layerT = drawLineFromPoint(start: start, toPoint: end, ofColor: .green, lineWidth: 35)
//        self.layer.insertSublayer(layerT, below: borderLayer)
//    }
//
//    private func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
//
//        //design the path
//        let path = UIBezierPath()
//        path.move(to: start)
//        path.addLine(to: end)
//
//        //design path in layer
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = path.cgPath
//        shapeLayer.strokeColor = lineColor.cgColor
//        shapeLayer.lineWidth = lineWidth
//        shapeLayer.lineCap = .round
//        return shapeLayer
//    }
//
//
//    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
//        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
//    }
//
//    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
//        return sqrt(CGPointDistanceSquared(from: from, to: to))
//    }
//}
