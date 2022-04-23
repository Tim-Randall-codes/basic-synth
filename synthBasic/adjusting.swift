//
//  adjusting.swift
//  synthBasic
//
//  Created by Tim Randall on 23/4/22.
//

import Foundation
import SwiftUI
import AudioKit
import SoundpipeAudioKit

// sounds OO for the adjustable sounds

class SoundsOO: ObservableObject {
    @Published var changed: Bool = true
    @Published var a: Float = 0
    @Published var d: Float = 0
    @Published var s: Float = 1
    @Published var r: Float = 0
    @Published var detune: Float = 1
    @Published var waveform: Table = Table(.sawtooth)
    lazy var osc1 = Oscillator(waveform: waveform, frequency: 440, amplitude: 0.8, detuningOffset: detune)
    lazy var filter1 = AmplitudeEnvelope(osc1, attackDuration: a, decayDuration: d, sustainLevel: s, releaseDuration: r)
    lazy var osc2 = Oscillator(waveform: waveform, frequency: 330, amplitude: 0.8, detuningOffset: detune)
    lazy var filter2 = AmplitudeEnvelope(osc2, attackDuration: a, decayDuration: d, sustainLevel: s, releaseDuration: r)
    lazy var osc3 = Oscillator(waveform: waveform, frequency: 220, amplitude: 0.8, detuningOffset: detune)
    lazy var filter3 = AmplitudeEnvelope(osc3, attackDuration: a, decayDuration: d, sustainLevel: s, releaseDuration: r)
    lazy var osc4 = Oscillator(waveform: waveform, frequency: 550, amplitude: 0.8, detuningOffset: detune)
    lazy var filter4 = AmplitudeEnvelope(osc4, attackDuration: a, decayDuration: d, sustainLevel: s, releaseDuration: r)
    lazy var osc5 = Oscillator(waveform: waveform, frequency: 660, amplitude: 0.8, detuningOffset: detune)
    lazy var filter5 = AmplitudeEnvelope(osc5, attackDuration: a, decayDuration: d, sustainLevel: s, releaseDuration: r)
}

struct MainViewA: View {
    @StateObject var adjustingSound = SoundsOO()
    @State var attackV: Double = 0.01 { didSet { adjustingSound.a = Float(attackV)}}
    @State var decayV: Double = 0 { didSet { adjustingSound.d = Float(decayV)}}
    @State var sustainV: Double = 1 { didSet { adjustingSound.s = Float(sustainV)
        adjustingSound.changed = true
    }}
    @State var releaseV: Double = 0.3 { didSet { adjustingSound.r = Float(releaseV)}}
    var body: some View {
        VStack{
            ButtonViewA(adjustingSound: adjustingSound, o1: adjustingSound.osc1, f: adjustingSound.filter1)
            ButtonViewA(adjustingSound: adjustingSound, o1: adjustingSound.osc2, f: adjustingSound.filter2)
            ButtonViewA(adjustingSound: adjustingSound, o1: adjustingSound.osc3, f: adjustingSound.filter3)
            ButtonViewA(adjustingSound: adjustingSound, o1: adjustingSound.osc4, f: adjustingSound.filter4)
            ButtonViewA(adjustingSound: adjustingSound, o1: adjustingSound.osc5, f: adjustingSound.filter5)
            Spacer()
            Slider(value: $attackV, in: 0...1)
            Slider(value: $decayV, in: 0...1)
            Slider(value: $sustainV, in: 0...1)
            Slider(value: $releaseV, in: 0...1)
        }
    }
}

struct ButtonViewA: View {
    @ObservedObject var adjustingSound: SoundsOO
    @State var playing: Bool = false
    var eng = AudioEngine()
    var o1: Oscillator
    var f: AmplitudeEnvelope
    var body: some View {
            Button(action:{
                startItUp()
            }, label:{
                Text("Play/stop")
            })
    }
    func startItUp(){
        if adjustingSound.changed == true {
            o1.start()
            os2.start()
            eng.output = f
            do { try eng.start()}
            catch { print("error starting engine")}
            adjustingSound.changed = false
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
