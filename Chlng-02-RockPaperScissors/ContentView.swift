//
//  ContentView.swift
//  Chlng-02-RockPaperScissors
//
//  Created by Андрей Бородкин on 09.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Initial setup
    
    enum Sign: String {
        case rock = "👊"
        case scissors = "✌️"
        case paper = "🖐️"
    }
    
    @State var signsArray: [Sign] = [.rock, .scissors, .paper]
    
    @State var shouldWin = Bool.random()
    @State var computerMove = Int.random(in: 0...2)
    
    var computerSign: Sign {
        let sign = signsArray[computerMove]
        return sign
    }
    
    @State var playerSign: Sign = .paper
    
    var prompt: String {
        shouldWin ? "You need to win" : "You need to loose"
    }
    
    // MARK: - Game logics
    
    @State var round = 0
    @State var score = 0
    
    
    func compareSigns(signA: Sign, signB: Sign) -> Int {
        switch signA {
        case .paper:
            switch signB {
            case .paper: return 0
            case .rock: return 1
            case .scissors: return -1
            }
        case .rock:
            switch signB {
            case .paper: return -1
            case .rock: return 0
            case .scissors: return 1
            }
        case .scissors:
            switch signB {
            case .paper: return 1
            case .rock: return -1
            case .scissors: return 0
            }
        }
    }
    
    
    func nextRound() {
        round += 1
        if round == 10 {
            round = 0
            score = 0
        }
        
        computerMove = Int.random(in: 0...2)
        shouldWin.toggle()
        
    }
    
    func signButtonTapped(sign: Sign) {
        playerSign = sign
        
        if shouldWin {
            score += compareSigns(signA: playerSign, signB: computerSign)
        } else {
            score -= compareSigns(signA: playerSign, signB: computerSign)
        }
        
       nextRound()
        
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Pick your sign")
                .font(.largeTitle)
            Text(prompt)
                .font(.headline)
            VStack {
                ForEach(signsArray, id: \.self) {item in
                    
                    Button {
                        signButtonTapped(sign: item)
                        
                    } label: {
                        Text(item.rawValue)
                            .font(.system(size: 72))
                            .frame(width: 100, height: 100)
                            .background( item == computerSign ? Color.red : Color.white)
                    }
                }
            }
            .padding()
            
            Text("Your score is \(score)")
                .font(.headline)
            Text("Round \(round)")
                .font(.subheadline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
