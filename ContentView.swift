//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Liko Setiawan on 06/02/24.
//

import SwiftUI

struct ContentView: View {
    
    private var choices = ["Rock", "Paper", "Scissor"]
    @State private var winOrLose = Bool.random()
    @State private var randomChoice = Int.random(in: 0...2)
    //    @State private var answerUser = 0
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var showAlert = false
    
    @State private var alertGameOver = false
    
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                Spacer()
                Spacer()
                LargeText(text: "Your Score is: \(score)")
                LargeText(text: "Bot choose : \(choices[randomChoice])")
                LargeText(text: "You have to : \(winOrLose ? "Win" : "Lose")")
                Spacer()
                
                VStack(spacing : 15){
                    VStack{
                        Text("Choose the answer ")
                            .font(.subheadline.weight(.heavy))
                    }
                    ForEach(choices, id: \.self){ id in
                        Button{
                            answerTapped(id)
                        }label: {
                            Text(id)
                                .font(.system(size: 45, weight: .bold))
                                .foregroundStyle(.black)
                                .shadow(radius: 5)
                                .help("Choose?")
                            
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showAlert){
            Button("Continue", action: nextQuestion)
        }message : {
            Text("You are \(scoreTitle == "Correct" ? "Correct your score increase by 1" : "Wrong")")
        }
        .alert("You just finished the game", isPresented: $alertGameOver) {
            Button("Restart the game", action: resetGame)
        }message: {
            Text("You are a rock paper scissor king!")
        }
                
    }
    
    func resetGame(){
        winOrLose = Bool.random()
        randomChoice = Int.random(in: 0...2)
        score = 0
        alertGameOver = false
    }
    
    
    func answerTapped(_ playerChoice : String){
        let playerWins = (playerChoice == "Rock" && randomChoice == 2) || (playerChoice == "Paper" && randomChoice == 0) || (playerChoice == "Scissor" && randomChoice == 1)
        
        if playerChoice == choices[randomChoice]{
            if score == 0 {
                scoreTitle = "Wrong"
                showAlert = true
            }else{
                scoreTitle = "Wrong"
                showAlert = true
                score -= 1
            }
        }else if (playerWins && winOrLose) || (!playerWins && !winOrLose) {
            if score < 10 {
                scoreTitle = "Correct"
                showAlert = true
                score += 1
            }else{
                alertGameOver = true
            }
        } else {
            if score == 0 {
                scoreTitle = "Wrong"
                showAlert = true
            }else{
                scoreTitle = "Wrong"
                showAlert = true
                score -= 1
            }
        }
        
        
    }
    
    func nextQuestion(){
        winOrLose = Bool.random()
        randomChoice = Int.random(in: 0...2)
    }
    
    
}




struct LargeText: View {
    
    var text: String
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
    }
}


#Preview {
    ContentView()
}
