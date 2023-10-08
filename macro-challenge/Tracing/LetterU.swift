//
//  LetterU.swift
//  TestTracing
//
//  Created by Kezia Gloria on 05/10/23.
//

import Foundation
import UIKit

class LetterU: Letter {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: Step Count
        super.stepsCount = 1
        super.addDottedLayers()
        
        self.createLetterForTracing(letter: "u")
        
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
        createDottedLine()
    }
    
    private func createDottedLine() {
        let cgPath = CGMutablePath()
        
        let p0 = CGPoint(x: quarterRatio * 1.3, y: quarterRatio * 2)
        let p1 = CGPoint(x: quarterRatio * 1.3, y: quarterRatio * 3)
        let p2 = CGPoint(x: quarterRatio * 2.7, y: quarterRatio * 3)
        let p3 = CGPoint(x: quarterRatio * 2.7, y: quarterRatio * 2)
        initPoint = p0
        
        cgPath.move(to: p0)
        cgPath.addLine(to: p1)
        cgPath.addCurve(to: p2, control1: CGPoint(x: quarterRatio * 1.3, y: quarterRatio * 4.1), control2: CGPoint(x: quarterRatio * 2.7, y: quarterRatio * 4.1))
        cgPath.addLine(to: p3)
        cgPath.move(to: p0)
        cgPath.closeSubpath()
        
        insertDottedLayer(step: 1, cgPath: cgPath)
        insertArrow(start: p2, end: p3)
    }
}
