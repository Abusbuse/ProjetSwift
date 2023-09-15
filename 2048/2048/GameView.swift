//
//  GameView.swift
//  2048
//
//  Created by Flavien Marck on 15/09/2023.
//

import SwiftUI

struct GameView: View {
    @StateObject private var game = Jeu2048()
    @StateObject private var swipeGestion = SwipeGestion()
    var body: some View {
        // Homepage (Title at the top, play button in the middle, footer at the bottom)
        VStack(spacing: 20) {
            // Title (Fixed at the top of the screen)
            VStack(spacing: 5) {
                Text("2048")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("Score: 0")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
            }
            Spacer()
            VStack(spacing: 1) {
                ForEach(0..<4) {
                    _ in
                    HStack(spacing: 1) {
                        ForEach(0..<4) {
                            __ in
                            Rectangle()
                                .foregroundColor(Color(UIColor(red: 0.76, green: 0.76, blue: 0.76, alpha: 1.00)))
                                .frame(width: 70, height: 70)
                                .cornerRadius(5)
                        }
                    }
                }
            }
            Spacer()
        }
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
        .navigationBarHidden(true)
    }
}
