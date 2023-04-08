//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ton Silva on 6/4/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countriesList = ["Argentina", "Brazil", "Estonia", "France", "Germany", "Ghana", "Ireland", "Israel", "Italy", "Monaco", "Morroco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                VStack {
                    Text("Tap the flag of")
                        .font(.title)
                    Text(countriesList[correctAnswer])
                        .font(.title)
                        .bold()
                }
                .padding()
                
                ForEach(0..<3) { number in
                    Button {
                        //
                    } label: {
                        Image(countriesList[number].lowercased())
                            .resizable()
                            .frame(maxWidth: 240, maxHeight: 120)
                    }
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
