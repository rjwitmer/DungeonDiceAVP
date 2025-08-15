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
    @State private var imageHidden: Bool = true
    
    enum Dice: Int, CaseIterable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        func roll() -> Int {    // Return a Random Roll based on the number of Dice Sides
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    var body: some View {
        VStack {

            Text("Dungeon Dice")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.red)
            
            Spacer()
            
            if !imageHidden{
                Image(systemName: "dice")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color.red)
            }
            
            Text(resultMessage)
                .font(.title)
                .fontWeight(.medium)
            

            
            Spacer()

            LazyHGrid(rows: [GridItem(.flexible(minimum: 100))]) {
                ForEach(Dice.allCases, id: \.self) { die in
                    Button("\(die.rawValue)-Sided") {
                        resultMessage = "You rolled a \(die.roll()) on a \(die)-sided die!"
                        imageHidden = false
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
