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
    
    private func tuileCouleur(value: Int) -> Color {
        switch value {
            case 2:
                //#fff3ed
                return Color(UIColor(red: 1.00, green: 0.95, blue: 0.93, alpha: 1.00))
            case 4:
                //#ffe3d4
                return Color(UIColor(red: 1.00, green: 0.89, blue: 0.83, alpha: 1.00))
            case 8:
                //#ffc2a9
                return Color(UIColor(red: 1.00, green: 0.76, blue: 0.66, alpha: 1.00))
            case 16:
                //#ff9e7a
                return Color(UIColor(red: 1.00, green: 0.62, blue: 0.48, alpha: 1.00))
            case 32:
                //#fe6339
                return Color(UIColor(red: 0.99, green: 0.39, blue: 0.22, alpha: 1.00))
            case 64:
                //#fc3a13
                return Color(UIColor(red: 0.99, green: 0.23, blue: 0.07, alpha: 1.00))
            case 128:
                //#ed2009
                return Color(UIColor(red: 0.93, green: 0.13, blue: 0.04, alpha: 1.00))
            case 256:
                //#c51309
                return Color(UIColor(red: 0.77, green: 0.08, blue: 0.04, alpha: 1.00))
            case 512:
                //#9c1110
                return Color(UIColor(red: 0.61, green: 0.07, blue: 0.06, alpha: 1.00))
            case 1024:
                //#9c1110
                return Color(UIColor(red: 0.61, green: 0.07, blue: 0.06, alpha: 1.00))
            case 2048:
                //#440607
                return Color(UIColor(red: 0.27, green: 0.02, blue: 0.03, alpha: 1.00))
            default:
                //Grey
                return Color(UIColor(red: 0.76, green: 0.76, blue: 0.76, alpha: 1.00))

        }
    }
  
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
                                            .foregroundColor(tuileCouleur(value: game.grid[y][x].value))
                                            .frame(width: 70, height: 70)
                                            .cornerRadius(5)
                                            .layoutPriority(1)
                                        if (game.grid[y][x].value != 0) {
                                            Text(String(game.grid[y][x].value))
                                            .foregroundColor(game.grid[y][x].value >= 64 ? Color.white : Color.black)
                                        }
                                    }
                                }
                            }
                        }
                    }.onAppear {
                        game.reset()
                    }.gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                        .onEnded { value in
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
