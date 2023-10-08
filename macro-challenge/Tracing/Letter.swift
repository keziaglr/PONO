//
//  Letter.swift
//  TestTracing
//
//  Created by Kezia Gloria on 08/10/23.
//

import Foundation
import UIKit

class Letter: UIView{
    var initPoint : CGPoint = .zero
    var dottedLayer: [CAShapeLayer] = []
    var stepsCount: Int = 0
    var bgColor = UIColor.white
    var lastPoint: CGPoint = .zero
    var borderLayer = CAShapeLayer()
    var quarterRatio: CGFloat {
        return self.bounds.width * 0.25
    }
    var touchPoint: CGPoint = .zero {
        didSet {
            self.createRatioCurve()
        }
    }
    
    var currStep: Int = 0 {
        didSet{
            nextStep()
        }
    }
    
    func nextStep()  {
        
    }
    
    func addDottedLayers() {
        self.dottedLayer = []  // Clear the existing layers if needed
        for _ in 0..<stepsCount {
            let shapeLayer = CAShapeLayer()
            shapeLayer.createDottedPath()
            dottedLayer.append(shapeLayer)
        }
        self.backgroundColor = bgColor
    }

    func createRatioCurve() {
        
        let startPoint = lastPoint
        if startPoint.distance(to: touchPoint) < 50{
            self.updateNavigationPath(start: startPoint, end: touchPoint)
        }
        lastPoint = touchPoint
    }
    
    private func updateNavigationPath(start: CGPoint, end: CGPoint) {
        let layerT = drawLineFromPoint(start: start, toPoint: end, ofColor: UIColor(named: "word-color")!, lineWidth: 40)
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

    func createLetterForTracing(letter: String) {
        let textLayer = CATextLayer()
        textLayer.string = letter
        textLayer.font = UIFont(name: "Quicksand-Bold", size: 250)
        textLayer.fontSize = CGFloat(self.bounds.height)
        textLayer.alignmentMode = .center
        textLayer.position = CGPoint(x: self.bounds.width, y: self.bounds.height/2)
        textLayer.bounds = self.bounds // Use the same size as the container view
        textLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        self.layer.mask = textLayer
        
    }
    
    //MARK: Step start from 1
    func insertDottedLayer(step: Int, cgPath: CGPath) {
        dottedLayer[step-1].path = cgPath
        self.layer.insertSublayer(dottedLayer[step-1], below: borderLayer)
    }
    
    func insertArrow(start: CGPoint, end: CGPoint) {
        let cgPath = CGMutablePath()
        let arrow = UIBezierPath()
        let arrowLayer = CAShapeLayer()
        
        arrow.addArrow(start: start, end: end, pointerLineLength: 15, arrowAngle: CGFloat(Double.pi / 5))
        arrowLayer.createArrowPath()
        cgPath.addPath(arrow.cgPath)
        arrowLayer.path = cgPath
        self.layer.insertSublayer(arrowLayer, below: borderLayer)
    }
}
