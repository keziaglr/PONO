//
//  TracingLetter.swift
//  TestTracing
//
//  Created by Kezia Gloria on 05/10/23.
//

import Foundation
import UIKit

class TracingLetter: UIView, UIGestureRecognizerDelegate {
    
    private var movingCircle = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    var frameSize: CGRect = .zero
    //Curve View
    private var letterB: LetterB?
    private var letterU: LetterU?
    private var letterK: LetterK?
    private var letterU2: LetterU?
    var lvl = 0
    var spacing = CGFloat(150)
    var w : CGFloat = 0.0
    var h : CGFloat = 0.0
    
    //Fill Prgress at trace
    private var curveProgress: CGFloat = 0.0
    
    //Pan Gesture Initial Point
    private var initialCenter = CGPoint()
    
    //Initial angle for rate the circle
    var lastRotation: CGFloat = 0
    
    //Navigation Arrow
    private var arrowImage = UIImage(named: "arrowDownCircleBlue")
    private var allPoints: [CGPoint] = []
    private var endPoint: CGPoint = .zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        frameSize = self.bounds
        self.w = frameSize.width/5
        self.h = frameSize.height/4
        self.initiateControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Setup All Control
    private func initiateControl() {
        self.initCurveView()
        self.initDraggingCircle(pos: CGPoint(x: (letterB?.initPoint.x)! + w, y: (letterB?.initPoint.y)! + h))
        self.setupGesture()
        self.initializePathArr(dot: letterB!.dottedLayer)
    }
    
}

private extension TracingLetter {
    
    /*
     Initialize movable circle direct view
     */
    func initDraggingCircle(pos: CGPoint) {
        self.movingCircle.layer.cornerRadius = self.movingCircle.bounds.height / 2
        self.movingCircle.image = arrowImage
        self.initialCenter = pos
        self.movingCircle.center = self.initialCenter
        self.addSubview(movingCircle)
        self.bringSubviewToFront(movingCircle)
    }
    
    /*
    Initialize movable circle direct view
    */
    func initCurveView() {
        letterB = LetterB(frame: CGRect(x: w, y: h, width: 280, height: 280))
        letterU = LetterU(frame: CGRect(x: w + spacing, y: h, width: 280, height: 280))
        letterK = LetterK(frame: CGRect(x: w + spacing * 2, y: h, width: 280, height: 280))
        letterU2 = LetterU(frame: CGRect(x: w + spacing * 3, y: h, width: 280, height: 280))
        letterB?.progress = curveProgress
        addSubview(letterU!)
        addSubview(letterB!)
        addSubview(letterK!)
        addSubview(letterU2!)
        
    }
}

//MARK: - Gesture Control
private extension TracingLetter {
    /*
     Initialize gesture to navigate and fill the curve
     Note: Only work inside of tracing view
     */
    func setupGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(gestureRecognizer:)))
        movingCircle.addGestureRecognizer(gesture)
        movingCircle.isUserInteractionEnabled = true
        gesture.delegate = self
    }
    
    //Gesture action method
    @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        guard gestureRecognizer.view != nil else {return}
        let piece = gestureRecognizer.view!
        let translation = gestureRecognizer.translation(in: piece.superview)
        
        if gestureRecognizer.state == .began {
           // Save the view's original position.
           self.initialCenter = piece.center
        }
           // Update the position for the .began, .changed, and .ended states
        if gestureRecognizer.state != .cancelled {
            let touchPoint: CGPoint = CGPoint(x: initialCenter.x, y: initialCenter.y + translation.y)
            if let point = getTracePoint() {
                let difference = touchPoint.distance(to: point)
                guard difference < 70.0 else {
                    return
                }
                if point == endPoint {
                    self.movingCircle.gestureRecognizers?.removeAll()
                }
                let newRotation = lastRotation + piece.center.angleRadian(between: point)
                self.movingCircle.transform = CGAffineTransform(rotationAngle: newRotation - 1)
                piece.center = point
                
                if lvl < 2{
                    self.letterB?.touchPoint = CGPoint(x: point.x - w, y: point.y - h)
                }else if lvl == 2{
                    self.letterU!.touchPoint = CGPoint(x: point.x - w - spacing, y: point.y - h)
                }
                else if lvl < 6{
                    self.letterK!.touchPoint = CGPoint(x: point.x - w - spacing * 2, y: point.y - h)
                }else{
                    self.letterU2!.touchPoint = CGPoint(x: point.x - w - spacing * 3, y: point.y - h)
                }
                self.allPoints.removeFirst()
            }
        }
        else {
           piece.center = initialCenter
            movingCircle.removeFromSuperview()
            self.gestureRecognizers?.forEach(self.removeGestureRecognizer)
            movingCircle = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            lvl+=1
            var pos = letterB?.initPoint
            //MARK: Letter B
            if lvl == 1{
                self.letterB?.nextStep()
                self.initializePathArr(dot: letterB!.dottedLayer2)
                pos = CGPoint(x: (letterU?.initPoint.x)! + w, y: (letterU?.initPoint.y)! + h)
            //MARK: Letter U
            }else if lvl == 2{
                pos = CGPoint(x: (letterU?.initPoint.x)! + w + spacing, y: (letterU?.initPoint.y)! + h)
                self.initializePathArr(dot: letterU!.dottedLayer)
            //MARK: Letter K
            }else if lvl == 3{
                self.initializePathArr(dot: letterK!.dottedLayer)
                pos = CGPoint(x: (letterK?.initPoint.x)! + w + spacing * 2, y: (letterK?.initPoint.y)! + h)
            }else if lvl == 4{
                self.letterK?.nextStep()
                self.initializePathArr(dot: letterK!.dottedLayer2)
                pos = CGPoint(x: (letterK?.initPoint.x)! + w + spacing * 2, y: (letterK?.initPoint.y)! + h)
            }
            else if lvl == 5{
                self.letterK?.nextStep2()
                self.initializePathArr(dot: letterK!.dottedLayer3)
                pos = CGPoint(x: (letterK?.initPoint.x)! + w + spacing * 2, y: (letterK?.initPoint.y)! + h)
            //MARK: Letter U
            }else{
                pos = CGPoint(x: (letterU2?.initPoint.x)! + w + spacing * 3, y: (letterU2?.initPoint.y)! + h)
                self.initializePathArr(dot: letterU2!.dottedLayer)
            }
            self.initDraggingCircle(pos: pos ?? .zero)
            self.setupGesture()
        }
    }
    
    func getTracePoint() -> CGPoint? {
        return self.allPoints.first
    }
    
    private func initializePathArr(dot: CAShapeLayer) {
        var tempP : [CGPoint] = []
        if let path = dot.path {
            let allP = path.getPathElementsPoints()
            for point in allP {
                if lvl < 2{
                    tempP.append(CGPoint(x: point.x + w, y: point.y + h))
                }else if lvl == 2{
                    tempP.append(CGPoint(x: point.x + w + spacing, y: point.y + h))
                }else if lvl < 6{
                    tempP.append(CGPoint(x: point.x + w + spacing * 2, y: point.y + h))
                }else{
                    tempP.append(CGPoint(x: point.x + w + spacing * 3, y: point.y + h))
                }
            }
            self.allPoints = tempP
        }
        self.endPoint = self.allPoints.last ?? .zero
    }
}
