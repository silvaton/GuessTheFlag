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
    @State private var userChoice: Int = 0
    
    @State private var resultTitle: String = ""
    @State private var score: Int = 0
    @State private var showingResult = false
    @State private var remainingRounds = 8
    @State private var alertTitle = ""
    @State private var roundString = "rounds"
    
    var body: some View {
        ZStack {
    //        LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
    //            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.black)

                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of:")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.black)
                        Text(countriesList[correctAnswer])
                            .font(.largeTitle.weight(.bold))
                            .foregroundColor(.black)
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
                        .modifier(FlagImage())                        
                    }
                }
                Spacer()
            }
        }
        .alert("\(resultTitle)!", isPresented: $showingResult) {
            Button(alertTitle, action: askQuestion)
        } message: {
            if resultTitle == "Wrong" && alertTitle == "Continue" {
                Text("Wrong! You selected the flag of \(countriesList[userChoice]).\n Your current score is \(score) and you have \(remainingRounds) more \(roundString).")
            } else if resultTitle == "Correct" && alertTitle == "Continue" {
                Text("Your answer is \(resultTitle).\n Your current score is \(score) and you have \(remainingRounds) more \(roundString).")
            } else {
                Text("\(resultTitle)! You selected the flag of \(countriesList[userChoice]).\n Your final score is \(score).")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if remainingRounds != 1 {
            remainingRounds -= 1
            checkUserChoice(number)
            updateRoundString()
            alertTitle = "Continue"
        } else {
            remainingRounds -= 1
            alertTitle = "Restart"
            checkUserChoice(number)
            userChoice = number
        }
        showingResult = true
    }
    
    func askQuestion() {
        if remainingRounds == 0 {
            remainingRounds = 8
            score = 0
            roundString = "rounds"
        }
        countriesList.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    fileprivate func checkUserChoice(_ number: Int) {
        userChoice = number
        if userChoice == correctAnswer {
            resultTitle = "Correct"
            score += 1
        } else {
            resultTitle = "Wrong"
            score -= 1
        }
    }
    
    fileprivate func updateRoundString() {
        if remainingRounds < 2 {
            roundString = "round"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(10)
            .shadow(color: .secondary, radius: 10)
    }
}
