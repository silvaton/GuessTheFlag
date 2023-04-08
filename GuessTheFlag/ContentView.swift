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
    
    @State private var resultTitle: String = ""
    @State private var showingResult = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                VStack {
                    Text("Tap the flag of")
                        .font(.title3)
                    Text(countriesList[correctAnswer])
                        .font(.largeTitle.weight(.bold))
                }
                .padding()
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
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
        .alert(resultTitle, isPresented: $showingResult) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your answer is \(resultTitle)")
            }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            resultTitle = "Correct"
        } else {
            resultTitle = "Wrong"
        }
        
        showingResult = true
    }
    
    func askQuestion() {
        countriesList.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
