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
var filter = AmplitudeEnvelope(mixer, attackDuration: 1, decayDuration: 0.01, sustainLevel: 0.8, releaseDuration: 0.7)

var engine2 = AudioEngine()
var oscTwo = Oscillator(waveform: Table(.square), frequency: 300, amplitude: 0.8, detuningOffset: 2, detuningMultiplier: 1)
var osc2Two = Oscillator(waveform: Table(.sine), frequency: 300, amplitude: 0.8, detuningOffset: 2, detuningMultiplier: 1)
var mixerTwo = Mixer(oscTwo, osc2Two)
var filterTwo = AmplitudeEnvelope(mixerTwo, attackDuration: 0.3, decayDuration: 0.01, sustainLevel: 0.8, releaseDuration: 0.3)

struct Sound {
    var freq: Float
    var amp: Float
    var detune: Float
    var a: Float
    var d: Float
    var s: Float
    var r: Float
    var engine = AudioEngine()
    lazy var osc = Oscillator(waveform: Table(.square), frequency: freq, amplitude: amp, detuningOffset: detune, detuningMultiplier: 1)
    lazy var osc2 = Oscillator(waveform: Table(.sine), frequency: freq, amplitude: amp, detuningOffset: detune, detuningMultiplier: 1)
    lazy var mixer = Mixer(oscTwo, osc2Two)
    lazy var filter = AmplitudeEnvelope(mixerTwo, attackDuration: a, decayDuration: d, sustainLevel: s, releaseDuration: r)
}

// view struct that has a button for each frequency. The 

var soundOne = Sound(freq: 600, amp: 1, detune: 2, a: 0.3, d: 0.01, s: 0.8, r: 0.3)

struct MainView: View {
    var body: some View {
        VStack{
            ContentView(eng: engine, o1: osc, o2: osc2, m: mixer, f: filter)
            ContentView(eng: engine2, o1: oscTwo, o2: osc2Two, m: mixerTwo, f: filterTwo)
            ContentView(eng: soundOne.engine, o1: soundOne.osc, o2: soundOne.osc2, m: soundOne.mixer, f: soundOne.filter)
        }
    }
}

struct ContentView: View {
    var eng: AudioEngine
    var o1: Oscillator
    var o2: Oscillator
    var m: Mixer
    var f: AmplitudeEnvelope
    @State var started: Bool = false
    @State var playing: Bool = false
    var body: some View {
            Button(action:{
                startItUp()
            }, label:{
                Text("Play/stop")
            })
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
