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
let osc = Oscillator(waveform: Table(.sine), frequency: 400, amplitude: 0.8)
let filter = AmplitudeEnvelope(osc, attackDuration: 1, decayDuration: 0.01, sustainLevel: 0.8, releaseDuration: 0.9)
// need to learn how to get the AmplitudeEnvelope to trigger release

struct ContentView: View {
    @State var playing: Bool = false

    var body: some View {
        VStack{
            Button(action:{
                startItUp()
            }, label:{
                Text("Start it up")
            })
            Button(action:{
                startNStop()
            }, label:{
                Text("stop and play it")
            })
        }
    }
    func startItUp() {
        osc.start()
        engine.output = filter
        do { try engine.start()}
        catch { print("error starting engine")}
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
    func startNStop() {
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
