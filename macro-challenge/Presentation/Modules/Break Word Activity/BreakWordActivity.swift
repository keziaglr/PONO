//
//  BreakWord.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import SwiftUI

struct BreakWordActivity: View {
    @State var width : CGFloat = 500
    @State var height : CGFloat = 200
    @State var screenWidth = CGFloat(UIScreen.main.bounds.width)
    @State var screenHeight = CGFloat(UIScreen.main.bounds.height)
    @State var crack : Bool = false
    @State var vm = FlowScreenViewModel()
    @State private var dragOffset : [CGFloat] = [0.0, 0.0]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("box")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width)
                    .position(CGPoint(x: screenWidth/2, y: screenHeight/2))
                    .opacity(crack ? 0 : 1)
                
                HStack(spacing: -15) {
                    SyllableLabel(position: "left", syllable: (vm.word?.syllables[0].content)!, height: height, show: $crack)
                        .offset(x: dragOffset[0])
                        .animation(.easeOut(duration: 1), value: dragOffset)
                        .onChange(of: crack) { newValue in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                dragOffset[0] = dragOffset[0] - 100.0
                            }
                        }
                    SyllableLabel(position: "right", syllable: (vm.word?.syllables[1].content)!, height: height, show: $crack)
                        .offset(x: dragOffset[1])
                        .animation(.easeOut(duration: 1), value: dragOffset)
                        .onChange(of: crack) { newValue in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                dragOffset[1] = dragOffset[1] + 100.0
                            }
                        }
                }
                .position(CGPoint(x: screenWidth/2, y: screenHeight/2))
                
                if !crack {
                    ZStack {
                        Path { path in
                            insertDottedPath(start: CGPoint(x: screenWidth/2, y: screenHeight/2-height/2), end : CGPoint(x: screenWidth/2, y: screenHeight/2+height/2), path: &path)
                        }.stroke(.black, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round, dash: [10]))
                            .gesture(
                                DragGesture(minimumDistance: height)
                                    .onChanged({ (value) in
                                        crack = true
                                    })
                        )
                    }
                    
                }
                
            }
        }
    }
    
    func insertDottedPath(start: CGPoint, end: CGPoint, path: inout Path){
        let pointerLineLength = 20.0
        let arrowAngle = CGFloat(Double.pi / 5)
        
        let startEndAngle = atan((end.y - start.y) / (end.x - start.x)) + ((end.x - start.x) < 0 ? CGFloat(Double.pi) : 0)
        let arrowLine1 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle + arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle + arrowAngle))
        let arrowLine2 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle - arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle - arrowAngle))
        
        path.move(to: start)
        path.addLine(to: end)
        path.move(to: arrowLine1)
        path.addLine(to: end)
        path.addLine(to: arrowLine2)
        path.move(to: arrowLine2)
        path.closeSubpath()
    }
}

struct BreakWord_Previews: PreviewProvider {
    static var previews: some View {
        BreakWordActivity()
    }
}
