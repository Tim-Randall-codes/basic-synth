//
//  ContentView.swift
//  synthBasic
//
//  Created by Tim Randall on 28/2/22.
//

import SwiftUI
import AudioKit
import SoundpipeAudioKit

// need to learn how to get the AmplitudeEnvelope to trigger release

struct ContentView: View {
    let engine = AudioEngine()
    let osc = Oscillator()
    @State var playing: Bool = false
    var body: some View {
        VStack{
            Button(action:{
                sound()
            }, label:{
                Text("Play")
            })
            Button(action:{
                
            }, label:{
                Text("stop")
            })
        }
    }
    func sound() {
        let filter = AmplitudeEnvelope(osc, attackDuration: 1, decayDuration: 0.0, sustainLevel: 1, releaseDuration: 0.5)
        // play
        if playing == false {
            osc.start()
            filter.openGate()
            engine.output = filter
            do { try engine.start()}
            catch { print("error starting engine")}
            playing = true
            }
        //stop
        else {
            filter.closeGate()
            let timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                osc.stop()
            }
            playing = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
