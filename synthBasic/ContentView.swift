//
//  ContentView.swift
//  synthBasic
//
//  Created by Tim Randall on 28/2/22.
//


import SwiftUI
import AudioKit
import SoundpipeAudioKit

var attack: Float = 0.01
var decay: Float = 0
var sustain: Float = 1
var release: Float = 0.3

// this stuff is just trying out multiple oscillators, Currently playing an a major chord.

var os1 = Oscillator(waveform: Table(.sawtooth), frequency: 440, amplitude: 0.8, detuningOffset: 1)
var os2 = Oscillator(waveform: Table(.sawtooth), frequency: 554.37, amplitude: 0.8, detuningOffset: 1)
var os3 = Oscillator(waveform: Table(.sawtooth), frequency: 659.26, amplitude: 0.8, detuningOffset: 1)
var mix = Mixer(os1, os2, os3)
var filtah = AmplitudeEnvelope(mix, attackDuration: 0.1, decayDuration: 0.01, sustainLevel: 0.9, releaseDuration: 0.3)

// the struct below will create a sound over the required frequencies.

struct Sounds {
    var a: Float
    var d: Float
    var s: Float
    var r: Float
    var detune: Float
    var waveform: Table
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


//the below array consists of instances of this sound with the sound's characteristics created. Names are commented

//saw loud
var tones : [Sounds] = [Sounds(a: 0.1, d: 0.01, s: 0.8, r: 0.3, detune: 1, waveform: Table(.sawtooth)),
//square pluck
                        Sounds(a: 0.1, d: 0.3, s: 0, r: 0.3, detune: 1, waveform: Table(.square)),
                        Sounds(a: 0.1, d: 0.2, s: 1, r: 0.3, detune: 1, waveform: Table(.sawtooth))]

// this is the view that shows all of the buttons. The sound the button plays is selected from the list using an integer inserted into this list.

struct MainView: View {
    @State var attackV: Double = 0.01 { didSet { attack = Float(attackV)}}
    @State var decayV: Double = 0 { didSet { decay = Float(decayV)}}
    @State var sustainV: Double = 1 { didSet { sustain = Float(sustainV)}}
    @State var releaseV: Double = 0.3 { didSet { release = Float(releaseV)}}
    var soundNumber: Int
    var body: some View {
        VStack{
            ButtonView(o1: tones[soundNumber].osc1, f: tones[soundNumber].filter1)
            ButtonView(o1: tones[soundNumber].osc2, f: tones[soundNumber].filter2)
            ButtonView(o1: tones[soundNumber].osc3, f: tones[soundNumber].filter3)
            ButtonView(o1: tones[soundNumber].osc4, f: tones[soundNumber].filter4)
            ButtonView(o1: tones[soundNumber].osc5, f: tones[soundNumber].filter5)
            Spacer()
            Slider(value: $attackV, in: 0...1)
            Slider(value: $decayV, in: 0...1)
            Slider(value: $sustainV, in: 0...1)
            Slider(value: $releaseV, in: 0...1)
        }
    }
}

//use this button below

struct ButtonView: View {
    @State var started: Bool = false
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
        if started == false {
            o1.start()
            os2.start()
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


