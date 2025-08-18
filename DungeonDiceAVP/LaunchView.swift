//
//  LaunchView.swift
//  DungeonDiceAVP
//
//  Created by Bob Witmer on 2025-08-18.
//

import SwiftUI

struct LaunchView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @State private var is3DWindowOpen = false
    @State private var resultMessage: String = ""
    @State private var imageName: String = "dice"
    @State private var animationTrigger: Bool = false
    @State private var isDoneAnimating: Bool = true
    
    var body: some View {
        VStack {
            
            titleView
            
            Spacer()
            
            diceAnimation
            
            resultMessageView
            
            Spacer()
            
            Button(is3DWindowOpen ? "Close Cube Window" : "Open Cube Window") {
                if is3DWindowOpen {
                    dismissWindow(id: "CubeWindow")
                    is3DWindowOpen = false
                } else {
                    openWindow(id: "CubeWindow")
                    is3DWindowOpen = true
                }
            }
            
            ButtonLayout(resultMessage: $resultMessage)
            
        }
        .padding()
    }
}

extension LaunchView {
    private var titleView: some View {
        Text("Dungeon Dice")
            .font(.extraLargeTitle)
            .fontWeight(.black)
            .foregroundColor(.red)
    }
    private var diceAnimation: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .scaleEffect(isDoneAnimating ? 1 : 0.6) // Animate between 60% and 100% size
            .opacity(isDoneAnimating ? 1 : 0.2)     // Set Opacity of Animation between 20% and 100%
            .frame(width: 100, height: 100)
            .foregroundStyle(Color.red)
            .onChange(of: animationTrigger) {
                isDoneAnimating = false // set to the beginnning "false" state
                withAnimation(.spring(response: 0.3, dampingFraction: 0.2)) {
                    isDoneAnimating = true
                }
            }
    }
    private var resultMessageView: some View {
        Text(resultMessage)
            .font(.title)
            .fontWeight(.medium)
        //                .rotation3DEffect(isDoneAnimating ? .degrees(360) : .degrees(0), axis: (x: 1, y: 0, z: 0))
        //                .onChange(of: animationTrigger) {
        //                    isDoneAnimating = false // set to the beginnning "false" state
        //                    withAnimation(.interpolatingSpring(duration: 0.6, bounce: 0.4)) {
        //                        isDoneAnimating = true
        //                    }
        //                }
    }
    
}

#Preview(windowStyle: .automatic) {
    LaunchView()
}
