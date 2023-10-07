//
//  LetterU.swift
//  TestTracing
//
//  Created by Kezia Gloria on 05/10/23.
//

import Foundation
import UIKit


class LetterB: UIView {
    var dottedLayer = CAShapeLayer()
    var dottedLayer2 = CAShapeLayer()
    var initPoint : CGPoint = .zero
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
        lastPoint = initPoint
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

extension LetterB {
    
    func nextStep(){
        self.createDottedLine2()
    }

    func createCurveForTracing() {
        
        // Create a text layer with the text you want to mask
        let textLayer = CATextLayer()
        textLayer.string = "b"
        textLayer.font = UIFont(name: "Quicksand-Bold", size: 250)
        textLayer.fontSize = CGFloat(self.bounds.height)
        textLayer.alignmentMode = .center
        textLayer.position = CGPoint(x: self.bounds.width, y: self.bounds.height/2)
        textLayer.bounds = self.bounds // Use the same size as the container view
        textLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        self.layer.mask = textLayer
    }
    
    func createDottedLine() {
        let quarterRatio = self.bounds.width * 0.25

        dottedLayer = CAShapeLayer()
        dottedLayer.createDottedPath()
        let cgPath = CGMutablePath()
        let cgPath2 = CGMutablePath()
        
        
        
        let p0 = CGPoint(x: quarterRatio * 1.25, y: quarterRatio)
        let p1 = CGPoint(x: quarterRatio * 1.25, y: quarterRatio * 3.9)
        initPoint = p0
        
        cgPath.move(to: p0)
        cgPath.addLine(to: p1)
        cgPath.move(to: p0)
        cgPath.closeSubpath()
        dottedLayer.path = cgPath
        
        let arrow = UIBezierPath()
        let arrowLayer = CAShapeLayer()
        
        arrow.addArrow(start: p0, end: p1, pointerLineLength: 20, arrowAngle: CGFloat(Double.pi / 5))
        arrowLayer.createArrowPath()
        cgPath2.addPath(arrow.cgPath)
        arrowLayer.path = cgPath2
        
        self.layer.insertSublayer(dottedLayer, below: borderLayer)
        self.layer.insertSublayer(arrowLayer, below: borderLayer)
    }
    
    func createDottedLine2() {
        let quarterRatio = self.bounds.width * 0.25
        dottedLayer2 = CAShapeLayer()
        dottedLayer2.createDottedPath()
        let cgPath = CGMutablePath()
        let cgPath2 = CGMutablePath()
        
        //TODO: fix the shape of the curve on b
        let p0 = CGPoint(x: quarterRatio * 1.7, y: quarterRatio * 2.25)
        let p1 = CGPoint(x: quarterRatio * 1.7, y: quarterRatio * 3.75)
        initPoint = p0
        cgPath.move(to: p0)
        cgPath.addCurve(to: p1, control1: CGPoint(x: quarterRatio * 3.5, y: quarterRatio * 2.25), control2: CGPoint(x: quarterRatio * 3.5, y: quarterRatio * 3.75))
        cgPath.move(to: p0)
        cgPath.closeSubpath()
        dottedLayer2.path = cgPath
        
        let arrow = UIBezierPath()
        let arrowLayer = CAShapeLayer()
        
        arrow.addArrow(start: p0, end: p1, pointerLineLength: 20, arrowAngle: CGFloat(Double.pi / 5))
        arrowLayer.createArrowPath()
        cgPath2.addPath(arrow.cgPath)
        arrowLayer.path = cgPath2
        
        self.layer.insertSublayer(dottedLayer2, below: borderLayer)
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
