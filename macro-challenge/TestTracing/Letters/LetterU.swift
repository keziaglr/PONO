//
//  LetterU.swift
//  TestTracing
//
//  Created by Kezia Gloria on 05/10/23.
//

import Foundation
import UIKit

class LetterU: UIView {
    var initPoint : CGPoint = .zero
    var dottedLayer = CAShapeLayer()
    private var curveLayer = CAShapeLayer()
    private var borderLayer = CAShapeLayer()
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
        if startPoint.distance(to: touchPoint) < 50{
            self.updateNavigationPath(start: startPoint, end: touchPoint)
        }
        lastPoint = touchPoint
        
    }
}

private extension LetterU {
    
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
        
        // Create a text layer with the text you want to mask
        let textLayer = CATextLayer()
        textLayer.string = "u"
        textLayer.font = UIFont(name: "Quicksand-Bold", size: 250)
        textLayer.fontSize = CGFloat(self.bounds.height)
        textLayer.alignmentMode = .center
        textLayer.position = CGPoint(x: self.bounds.width, y: self.bounds.height/2)
        textLayer.bounds = self.bounds // Use the same size as the container view
        textLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        self.layer.mask = textLayer
    }
    
    private func createDottedLine() {
        let quarterRatio = self.bounds.width * 0.25

        dottedLayer = CAShapeLayer()
        dottedLayer.createDottedPath()
        let cgPath = CGMutablePath()
        
        let p3 = CGPoint(x: quarterRatio * 2.7, y: quarterRatio * 2)
        let p2 = CGPoint(x: quarterRatio * 2.7, y: quarterRatio * 3)
        let p1 = CGPoint(x: quarterRatio * 1.3, y: quarterRatio * 3)
        let p0 = CGPoint(x: quarterRatio * 1.3, y: quarterRatio * 2)
        initPoint = p0
        cgPath.move(to: p0)
        cgPath.addLine(to: p1)
        cgPath.addCurve(to: p2, control1: CGPoint(x: quarterRatio * 1.3, y: quarterRatio * 4.1), control2: CGPoint(x: quarterRatio * 2.7, y: quarterRatio * 4.1))
        cgPath.addLine(to: p3)
        cgPath.move(to: p0)
        cgPath.closeSubpath()
        dottedLayer.path = cgPath
        
        let arrow = UIBezierPath()
        let arrowLayer = CAShapeLayer()
        let cgPath2 = CGMutablePath()
        
        arrow.addArrow(start: p2, end: p3, pointerLineLength: 20, arrowAngle: CGFloat(Double.pi / 5))
        arrowLayer.createArrowPath()
        cgPath2.addPath(arrow.cgPath)
        arrowLayer.path = cgPath2
        
        self.layer.insertSublayer(dottedLayer, below: borderLayer)
        self.layer.insertSublayer(arrowLayer, below: borderLayer)
    }
    
    
    private func updateNavigationPath(start: CGPoint, end: CGPoint) {
        let layerT = drawLineFromPoint(start: start, toPoint: end, ofColor: .green, lineWidth: 40.0)
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
