//
//  CubeModel3DView.swift
//  DungeonDiceAVP
//
//  Created by Bob Witmer on 2025-08-18.
//

import SwiftUI
import RealityKit
//import RealityKitContent

struct CubeModel3DView: View {
    @State private var rotationY: Double = 0.0
    var body: some View {
        Model3D(named: "Cube")
            .padding3D(.back, 80)
            .rotation3DEffect(Angle(degrees: rotationY), axis: (x: 0, y: 1, z: 0))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        self.rotationY += Double(value.translation.width / 100)
                        self.rotationY = rotationY.truncatingRemainder(dividingBy: 360)
                    }
            )
            .ornament(attachmentAnchor: .scene(.bottom)) {
                Text("Pretend it's a die")
                    .padding()
                    .glassBackgroundEffect()
            }
    }
}

#Preview {
    CubeModel3DView()
}
