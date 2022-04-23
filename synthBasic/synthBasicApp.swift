//
//  synthBasicApp.swift
//  synthBasic
//
//  Created by Tim Randall on 28/2/22.
//

import SwiftUI

@main
struct synthBasicApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(soundNumber: 2)
        }
    }
}

class NumberOO: ObservableObject {
    var num: Float = 0.01
}
