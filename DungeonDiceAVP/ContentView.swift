//
//  ContentView.swift
//  DungeonDiceAVP
//
//  Created by Bob Witmer on 2025-08-15.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var resultMessage: String = ""
    @State private var imageName: String = ""
    @State private var imageHidden: Bool = true
    @State private var textHidden: Bool = true
    @State private var animationTrigger: Bool = false
    @State private var isDoneAnimating: Bool = true
    
    enum Dice: Int, CaseIterable, Identifiable {
        
        
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        var id: Int {
            return self.rawValue    // Each rawValue is unique in the Dice enum
        }
        
        var description: String {
            return String(self.rawValue) + "-Sided"
        }
        
        func roll() -> Int {    // Return a Random Roll based on the number of Dice Sides
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    var body: some View {
        VStack {
            
            Text("Dungeon Dice")
                .font(.extraLargeTitle)
                .fontWeight(.black)
                .foregroundColor(.red)
                  
            Spacer()
            
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
             
            Spacer()
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 172))], spacing: 60) {
                ForEach(Dice.allCases) { die in
                    Button(die.description) {
                        resultMessage = "You rolled a \(die.roll()) on a \(die)-sided die!"
                        imageName = "dice"
                        imageHidden = false
                        animationTrigger.toggle()
                        textHidden = false
                    }
                }
            }
            .tint(Color.red)
            .font(.largeTitle)
            
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
