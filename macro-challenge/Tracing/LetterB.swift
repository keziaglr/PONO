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
        
        //TODO: fix the shape of the curve on b
        let p0 = CGPoint(x: quarterRatio * 1.5, y: quarterRatio * 2.25)
        let p1 = CGPoint(x: quarterRatio * 1.5, y: quarterRatio * 3.75)
        initPoint = p0
        
        cgPath.move(to: p0)
        cgPath.addCurve(to: p1, control1: CGPoint(x: quarterRatio * 3.5, y: quarterRatio * 2.25), control2: CGPoint(x: quarterRatio * 3.5, y: quarterRatio * 3.75))
        cgPath.move(to: p0)
        cgPath.closeSubpath()
        
        insertDottedLayer(step: 2, cgPath: cgPath)
        insertArrow(start: p0, end: p1)
    }
    
}
