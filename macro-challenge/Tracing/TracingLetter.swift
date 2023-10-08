//
//  TracingLetter.swift
//  TestTracing
//
//  Created by Kezia Gloria on 05/10/23.
//

import Foundation
import UIKit

class TracingLetter: UIView, UIGestureRecognizerDelegate {
    
    private var movingCircle = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    var frameSize: CGRect = .zero
    private var letters: [Letter] = []
    var lvl = 0
    var spacing = CGFloat(150)
    var w : CGFloat = 0.0
    var h : CGFloat = 0.0
    
    //Fill Prgress at trace
    private var curveProgress: CGFloat = 0.0
    
    //Pan Gesture Initial Point
    private var initialCenter = CGPoint()
    
    
    //Navigation Arrow
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
        self.initLetterView()
        self.initDraggingCircle(pos: CGPoint(x: letters[0].initPoint.x + w, y: letters[0].initPoint.y + h), step: letters[0].currStep)
        self.setupGesture()
        self.initializePathArr(dot: letters[0].dottedLayer[0])
    }
    
}

private extension TracingLetter {
    
    /*
     Initialize movable circle direct view
     */
    func initDraggingCircle(pos: CGPoint, step: Int) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        label.textAlignment = .center
        label.font = UIFont(name: "Quicksand-Bold", size: 20)
        label.text = String(step)
        label.textColor = UIColor(named: "brown") // Set text color as needed
        self.movingCircle.addSubview(label)
        self.movingCircle.bringSubviewToFront(label)
        
        self.movingCircle.layer.cornerRadius = self.movingCircle.bounds.height / 2
        self.movingCircle.backgroundColor = UIColor(named: "orange")
        self.initialCenter = pos
        self.movingCircle.center = self.initialCenter
        self.addSubview(movingCircle)
        self.bringSubviewToFront(movingCircle)
        
    }
    
    /*
    Initialize movable circle direct view
    */
    func initLetterView() {
        //MARK: Change the letter
        letters.append(LetterB(frame: CGRect(x: w, y: h, width: 280, height: 280)))
        letters.append(LetterU(frame: CGRect(x: w + spacing, y: h, width: 280, height: 280)))
        letters.append(LetterK(frame: CGRect(x: w + spacing * 2, y: h, width: 280, height: 280)))
        letters.append(LetterU(frame: CGRect(x: w + spacing * 3, y: h, width: 280, height: 280)))
       
        for letter in letters{
            addSubview(letter)
        }
        
        if let letterB = letters[0] as? LetterB {
            letterB.currStep += 1
        }
        
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
                piece.center = point
                
                var cumulativeSteps = 0
                var index = 0

                for (i, letter) in letters.enumerated() {
                    cumulativeSteps += letter.stepsCount
                    if lvl < cumulativeSteps {
                        index = i
                        break
                    }
                }

                self.letters[index].touchPoint = CGPoint(x: point.x - w - CGFloat(index) * spacing, y: point.y - h)
                
                self.allPoints.removeFirst()
            }
        }
        else {
           piece.center = initialCenter

            nextLevel()
        }
    }
    
    func resetMovingCircle(){
        movingCircle.removeFromSuperview()
        self.gestureRecognizers?.forEach(self.removeGestureRecognizer)
        movingCircle = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    }
    
    func nextLevel(){
        resetMovingCircle()
        
        lvl+=1
        var index = 0
        var pos = letters[0].initPoint

        for (i, letter) in letters.enumerated() {
            let cumulativeSteps = letters.prefix(i).map { $0.stepsCount }.reduce(0, +)
            if lvl < cumulativeSteps + letter.stepsCount {
                index = i
                break
            }
        }

        if index < letters.count {
            let letter = letters[index]
            
            letter.currStep += 1

            pos = CGPoint(x: letter.initPoint.x + w + CGFloat(index) * spacing, y: letter.initPoint.y + h)
            let pathLayerIndex = letter.currStep - 1
            if pathLayerIndex >= 0 && pathLayerIndex < letter.dottedLayer.count {
                self.initializePathArr(dot: letter.dottedLayer[pathLayerIndex])
            }
            self.initDraggingCircle(pos: pos, step: letter.currStep)
        }
        
        self.setupGesture()
    }
    
    func getTracePoint() -> CGPoint? {
        return self.allPoints.first
    }
    
    private func initializePathArr(dot: CAShapeLayer) {
        var tempP : [CGPoint] = []
        if let path = dot.path {
            let allP = path.getPathElementsPoints()
            for point in allP {
                var cumulativeSteps = 0
                var index = 0

                for (i, letter) in letters.enumerated() {
                    cumulativeSteps += letter.stepsCount
                    if lvl < cumulativeSteps {
                        index = i
                        break
                    }
                }

                tempP.append(CGPoint(x: point.x + w + CGFloat(index) * spacing, y: point.y + h))
            }
            self.allPoints = tempP
        }
        self.endPoint = self.allPoints.last ?? .zero
    }
}
