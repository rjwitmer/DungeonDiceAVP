//
//  DungeonDiceAVPApp.swift
//  DungeonDiceAVP
//
//  Created by Bob Witmer on 2025-08-15.
//

import SwiftUI

@main
struct DungeonDiceAVPApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
        }
        WindowGroup(id: "CubeWindow") {
            CubeModel3DView()
        }
        .defaultSize(width: 500, height: 500)
    }
}


