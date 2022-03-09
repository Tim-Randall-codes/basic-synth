//
//  ContentView.swift
//  synthBasic
//
//  Created by Tim Randall on 28/2/22.
//

import SwiftUI
import AudioKit
import SoundpipeAudioKit

let number: Float = 440
var engine = AudioEngine()
var osc = Oscillator(waveform: Table(.sawtooth), frequency: number, amplitude: 0.8)
var osc2 = Oscillator(waveform: Table(.square), frequency: number, amplitude: 0.8, detuningOffset: 2, detuningMultiplier: 1)
var mixer = Mixer(osc, osc2)
var filter = AmplitudeEnvelope(osc, attackDuration: 1, decayDuration: 0.01, sustainLevel: 0.8, releaseDuration: 0.7)

// it has sine square and sawtooth

struct ContentView: View {
    var eng: AudioEngine
    var o1: Oscillator
    var o2: Oscillator
    var m: Mixer
    var f: AmplitudeEnvelope
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
            o1.start()
            o2.start()
            eng.output = f
            do { try eng.start()}
            catch { print("error starting engine")}
            started = true
        }
        // stop
        if playing == true {
            f.closeGate()
            playing = false
            }
        // play
        else {
            f.openGate()
            playing = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(eng: engine, o1: osc, o2: osc2, m: mixer, f: filter)
    }
}
