//
//  ButtonLayout.swift
//  DungeonDiceAVP
//
//  Created by Bob Witmer on 2025-08-18.
//

import SwiftUI

struct ButtonLayout: View {
    
    enum Dice: Int, CaseIterable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    // Create a preference key structure which will be used to pass variables up from the child to the parent View
    struct DeviceWidthPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
        
        typealias Value = CGFloat
        
    }
    
    @State private var overflowButtons = 0  // # of buttons in a less than full row
    
    @Binding var resultMessage: String        // Declare a Binding variable in the Child
    
    let horizontalPadding: CGFloat = 16     // default padding size of '.padding()'
    let spacing: CGFloat = 0                // between buttons
    let buttonWidth: CGFloat = 200          // width of button
    
    var body: some View {
        
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: buttonWidth), spacing: spacing)]) {
                ForEach(Dice.allCases.dropLast(overflowButtons), id: \.self) { dice in
                    Button("\(dice.rawValue)-sided") {
                        resultMessage = "You rolled a \(dice.roll()) on a\n \(dice)-sided dice"
                    }
                    .frame(width: buttonWidth)
                }
                .font(.largeTitle)
                .tint(.red)
            }
            HStack {
                ForEach(Dice.allCases.suffix(overflowButtons), id: \.self) { dice in
                    Button("\(dice.rawValue)-sided") {
                        resultMessage = "You rolled a \(dice.roll()) on a\n \(dice)-sided dice"
                    }
                    .frame(width: buttonWidth)
                }
                .font(.largeTitle)
                .tint(.red)
                .padding()
            }
        }
        .overlay {
            GeometryReader { geo in
                Color.clear
                    .preference(key: DeviceWidthPreferenceKey.self, value: geo.size.width)
            }
        }
        .onPreferenceChange(DeviceWidthPreferenceKey.self) { deviceWidth in
            arrangeGridItems(deviceWidth: deviceWidth)
        }
        
    }
    
    func arrangeGridItems(deviceWidth: CGFloat) {
        var screenWidth = deviceWidth - (horizontalPadding * 2)  // padding on both sides
        if Dice.allCases.count > 1 {
            screenWidth += spacing
        }
        
        // calculate the number of buttons in each row
        let numberOfButtonsPerRow = Int(screenWidth) / Int(buttonWidth + spacing)
        overflowButtons = Dice.allCases.count % numberOfButtonsPerRow
        
    }
}

#Preview {
    ButtonLayout(resultMessage: .constant(""))
}
