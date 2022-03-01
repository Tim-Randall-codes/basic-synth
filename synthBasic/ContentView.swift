//
//  ContentView.swift
//  synthBasic
//
//  Created by Tim Randall on 28/2/22.
//

import SwiftUI
import AudioKit
import SoundpipeAudioKit

let engine = AudioEngine()
let osc = Oscillator(waveform: Table(.sine), frequency: 1600, amplitude: 0.8)
let filter = AmplitudeEnvelope(osc, attackDuration: 1, decayDuration: 0.01, sustainLevel: 0.8, releaseDuration: 0.3)
// can pass these as properties into the view structs!

struct ContentView: View {
    @State var started: Bool = false
    @State var playing: Bool = false
    var body: some View {
        VStack{
            Button(action:{
                startItUp()
            }, label:{
                Text("Play/stop")
            })
        }
    }
    func startItUp() {
        if started == false {
            osc.start()
            engine.output = filter
            do { try engine.start()}
            catch { print("error starting engine")}
            started = true
        }
        // stop
        if playing == true {
            filter.closeGate()
            playing = false
            }
        // play
        else {
            filter.openGate()
            playing = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
