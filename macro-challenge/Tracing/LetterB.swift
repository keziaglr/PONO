//
//  LetterU.swift
//  TestTracing
//
//  Created by Kezia Gloria on 05/10/23.
//

import Foundation
import UIKit


class LetterB: Letter {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: Step Count
        super.stepsCount = 2
        super.addDottedLayers()

        self.createLetterForTracing(letter: "b")
        
        lastPoint = initPoint
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var currStep: Int {
            didSet {
                nextStep()
            }
        }
    
    override func nextStep() {
        if currStep == 1{
            createDottedLine()
        }else{
            createDottedLine2()
        }
    }
    
    func createDottedLine() {
        let cgPath = CGMutablePath()
        
        let p0 = CGPoint(x: quarterRatio * 1.25, y: quarterRatio)
        let p1 = CGPoint(x: quarterRatio * 1.25, y: quarterRatio * 3.9)
        initPoint = p0
        
        cgPath.move(to: p0)
        cgPath.addLine(to: p1)
        cgPath.move(to: p0)
        cgPath.closeSubpath()
        
        insertDottedLayer(step: 1, cgPath: cgPath)
        insertArrow(start: p0, end: p1)
    }
    
    func createDottedLine2() {
        let cgPath = CGMutablePath()
        // Replace with your desired value
        let p0 = CGPoint(x: quarterRatio * 2.05, y: quarterRatio * 2.95)
        let radius: CGFloat = 60

        // Calculate the starting and ending angles
        let startAngle: CGFloat = 1.2 * .pi
        let endAngle: CGFloat = 2.8 * .pi

        // Move the path to the initial point
        initPoint = CGPoint(x: p0.x + radius * cos(startAngle), y: p0.y + radius * sin(startAngle))

        // Add the arc to the path
        cgPath.addArc(
            center: p0,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        
        insertDottedLayer(step: 2, cgPath: cgPath)
        insertArrow(start: CGPoint(x: p0.x + radius * cos(endAngle), y: p0.y + 30 + radius * sin(endAngle)), end: CGPoint(x: p0.x + radius * cos(endAngle), y: p0.y + radius * sin(endAngle)))
    }
    
}
