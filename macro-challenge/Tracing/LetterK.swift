//
//  LetterU.swift
//  TestTracing
//
//  Created by Kezia Gloria on 05/10/23.
//

import Foundation
import UIKit


class LetterK: Letter {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: Step Count
        super.stepsCount = 3
        super.addDottedLayers()
        
        self.backgroundColor = super.bgColor
        self.createLetterForTracing(letter: "k")
        
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
        }else if currStep == 2{
            createDottedLine2()
        }else if currStep == 3{
            createDottedLine3()
        }
    }
    
    func createDottedLine() {
        let cgPath = CGMutablePath()
        
        let p0 = CGPoint(x: quarterRatio * 1.4, y: quarterRatio)
        let p1 = CGPoint(x: quarterRatio * 1.4, y: quarterRatio * 3.9)
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
        
        let p0 = CGPoint(x: quarterRatio * 2.9, y: quarterRatio * 1.9)
        let p1 = CGPoint(x: quarterRatio * 1.7, y: quarterRatio * 3)
        initPoint = p0
        cgPath.move(to: p0)
        cgPath.addLine(to: p1)
        cgPath.move(to: p0)
        cgPath.closeSubpath()
        
        insertDottedLayer(step: 2, cgPath: cgPath)
        insertArrow(start: p0, end: p1)
    }
    
    func createDottedLine3() {
        let cgPath = CGMutablePath()
        
        let p0 = CGPoint(x: quarterRatio * 1.9, y: quarterRatio * 2.8)
        let p1 = CGPoint(x: quarterRatio * 2.9, y: quarterRatio * 3.9)
        initPoint = p0
        cgPath.move(to: p0)
        cgPath.addLine(to: p1)
        cgPath.move(to: p0)
        cgPath.closeSubpath()
        
        insertDottedLayer(step: 3, cgPath: cgPath)
        insertArrow(start: p0, end: p1)
    }
}
