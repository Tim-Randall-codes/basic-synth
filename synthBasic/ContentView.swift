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

var soundOne = Sound(freq: 600, amp: 1, detune: 2, a: 0.3, d: 0.01, s: 0.8, r: 0.3)

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
                        Sounds(a: 0.1, d: 0.3, s: 0, r: 0.3, detune: 1, waveform: Table(.square))]


// this is the view that shows all of the buttons. The sound the button plays is selected from the list using an integer inserted into this list.

struct MainView: View {
    var soundNumber: Int
    var body: some View {
        VStack{
            ButtonView2(o1: tones[soundNumber].osc1, f: tones[soundNumber].filter1)
            ButtonView2(o1: tones[soundNumber].osc2, f: tones[soundNumber].filter2)
            ButtonView2(o1: tones[soundNumber].osc3, f: tones[soundNumber].filter3)
            ButtonView2(o1: tones[soundNumber].osc4, f: tones[soundNumber].filter4)
            ButtonView2(o1: tones[soundNumber].osc5, f: tones[soundNumber].filter5)
        }
    }
}

struct ButtonView: View {
    var eng = AudioEngine()
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

//use this button below

struct ButtonView2: View {
    var eng = AudioEngine()
    var o1: Oscillator
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
        MainView(soundNumber: 1)
    }
}
