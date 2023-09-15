//
//  ContentView.swift
//  2048
//
//  Created by Flavien Marck on 15/09/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            // Homepage (Title at the top, play button in the middle, footer at the bottom)
            VStack(spacing: 20) {
                // Title (Fixed at the top of the screen)
                Spacer()
                HStack(spacing: 0) {
                    Text("2048")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                }
                Spacer()
                NavigationLink(
                    destination: GameView(),
                    label: {
                        Text("Nouvelle partie")
                        .frame(
                            // Has a width of 80% of the screen
                            width: UIScreen.main.bounds.width * 0.7
                        )
                        .padding()
                    }
                )
                // .buttonStyle(PlainButtonStyle())
                .background(Color(UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1.00)))
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 10, x: 1, y: 1)
                .padding()
                Spacer()
                Spacer()
                // Footer (Fixed at the bottom of the screen)
                VStack(spacing: 15) {
                    Text("Réalisé par Flavien Marck (et Grégory Wittmann)")
                        .font(.footnote)
                    Text("2023 - IUTSD")
                        .font(.footnote)
                }
                .foregroundColor(.white)
            }
            .background(
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
