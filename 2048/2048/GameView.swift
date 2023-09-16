//
//  GameView.swift
//  2048
//
//  Created by Flavien Marck on 15/09/2023.
//

import SwiftUI

struct GameView: View {
    @StateObject private var game = Jeu2048();
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
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
                            y in
                            HStack(spacing: 1) {
                                ForEach(0..<4) {
                                    x in
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color(UIColor(red: 0.76, green: 0.76, blue: 0.76, alpha: 1.00)))
                                            .frame(width: 70, height: 70)
                                            .cornerRadius(5)
                                            .layoutPriority(1)
                                        if (game.grid[y][x].value != 0) {
                                            Text(String(game.grid[y][x].value))
                                        }
                                    }
                                }
                            }
                        }
                    }.onAppear {
                        game.reset()
                    }.gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                        .onEnded { value in
                            print(value.translation)
                            switch (value.translation.width, value.translation.height) {
                                case (...0, -30...30):  game.move(direction: .left)
                                case (0..., -30...30):  game.move(direction: .right)
                                case (-100...100, ...0):  game.move(direction: .up)
                                case (-100...100, 0...):  game.move(direction: .down)
                                default: break
                            }
                    })
                    Spacer()
                }
                .background(
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                )

                // Back button, aligned at the top left of the screen
                HStack {
                    Button(
                        action: {
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        label: {
                            Text("< Accueil")
                            .padding(10)
                        }
                    )
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(Color(UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1.00)))
                    .cornerRadius(5)
                    .padding()
                    Spacer()
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
        .navigationBarHidden(true)
    }
}