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
            ContentView(eng: engine, o1: osc, o2: osc2, m: mixer, f: filter)
        }
    }
}
