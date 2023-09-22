//
//  algo2048.swift
//  2048
//
//  Created by Gregory Wittmann on 9/15/23.
//

import Foundation
import Combine

struct Tuile {
    var value: Int
    var tuileEvo: Bool
}

class Jeu2048: ObservableObject {
    let grideSize = 4
    @Published var grid: [[Tuile]] = []
    @Published var score: Int = 0
    @Published var finished: Bool = false
    
    init() {
        for _ in 0..<grideSize {
            var row: [Tuile] = []
            for _ in 0..<grideSize {
                row.append(Tuile(value: 0, tuileEvo: false))
            }
            grid.append(row)
        }
    }

    func incrScore(v: Int) {
        score += v
    }

    // fonction qui permet de faire apparaitre 2 tuiles de valeur 2 ou 4 aléatoirement
    func generateRandomTuile() {
        if (isFull() || isLose()) {
            return
        }
        var row = Int.random(in: 0..<grideSize)
        var col = Int.random(in: 0..<grideSize)
        while grid[row][col].value != 0 {
            row = Int.random(in: 0..<grideSize)
            col = Int.random(in: 0..<grideSize)
        }
        grid[row][col].value = Int.random(in: 1..<3) * 2
        incrScore(v: grid[row][col].value)
    }

    // Fonction qui permet de gérer le mouvement dans les 4 directions
    func move(direction: Direction) {
        switch direction {
            case .up:
                moveUp()
            case .down:
                moveDown()
            case .left:
                moveLeft()
            case .right:
                moveRight()
            default:
                return
        }
        generateRandomTuile()
        if (isWin() || isLose()) {
            finished = true
        }
    }

    // Fonction qui va déplacer les tuiles vers le haut
    func moveUp() {
        for col in 0..<grideSize {
            for row in 1..<grideSize {
                if grid[row][col].value != 0 {
                    var nextRow = row - 1
                    while nextRow > 0 && grid[nextRow][col].value == 0 {
                        nextRow -= 1
                    }
                    if nextRow >= 0 {
                        if grid[nextRow][col].value == grid[row][col].value {
                            mergeTuile(row: nextRow, col: col, nextRow: row, nextCol: col)
                        } else if grid[nextRow][col].value > 0 {
                            nextRow += 1
                        }
                    }
                    if nextRow != row {
                        grid[nextRow][col].value = grid[row][col].value
                        grid[row][col].value = 0
                    }
                }
            }
        }
    }

    // Fonction qui va déplacer les tuiles vers le bas
    func moveDown() {
        for col in 0..<grideSize {
            for row in (0..<grideSize - 1).reversed() {
                if grid[row][col].value != 0 {
                    var nextRow = row + 1
                    while nextRow < grideSize - 1 && grid[nextRow][col].value == 0 {
                        nextRow += 1
                    }
                    if nextRow < grideSize {
                        if grid[nextRow][col].value == grid[row][col].value {
                            mergeTuile(row: nextRow, col: col, nextRow: row, nextCol: col)
                        } else if grid[nextRow][col].value > 0 {
                            nextRow -= 1
                        }
                    }
                    if nextRow != row {
                        grid[nextRow][col].value = grid[row][col].value
                        grid[row][col].value = 0
                    }
                }
            }
        }
    }

    // Fonction qui va déplacer les tuiles vers la gauche
    func moveLeft() {
        for row in 0..<grideSize {
            for col in 1..<grideSize {
                if grid[row][col].value != 0 {
                    var nextCol = col - 1
                    while nextCol > 0 && grid[row][nextCol].value == 0 {
                        nextCol -= 1
                    }
                    if nextCol >= 0 {
                        if grid[row][nextCol].value == grid[row][col].value {
                            mergeTuile(row: row, col: nextCol, nextRow: row, nextCol: col)
                        } else if grid[row][nextCol].value > 0 {
                            nextCol += 1
                        }
                    }
                    if nextCol != col {
                        grid[row][nextCol].value = grid[row][col].value
                        grid[row][col].value = 0
                    }
                }
            }
        }
    }

    // Fonction qui va déplacer les tuiles vers la droite
    func moveRight() {
        for row in 0..<grideSize {
            for col in (0..<grideSize - 1).reversed() {
                if grid[row][col].value != 0 {
                    var nextCol = col + 1
                    while nextCol < grideSize - 1 && grid[row][nextCol].value == 0 {
                        nextCol += 1
                    }
                    if nextCol < grideSize {
                        if grid[row][nextCol].value == grid[row][col].value {
                            mergeTuile(row: row, col: nextCol, nextRow: row, nextCol: col)
                        } else if grid[row][nextCol].value > 0 {
                            nextCol -= 1
                        }
                    }
                    if nextCol != col {
                        grid[row][nextCol].value = grid[row][col].value
                        grid[row][col].value = 0
                    }
                }
            }
        }
    }

    // Fonction qui fusionner les tuiles (si et seulement si elles ont la même valeur)
    func mergeTuile(row: Int, col: Int, nextRow: Int, nextCol: Int) {
        grid[nextRow][nextCol].value *= 2
        grid[nextRow][nextCol].tuileEvo = true
        grid[row][col].value = 0
        incrScore(v: grid[nextRow][nextCol].value)
    }

    // Fonction qui permet de savoir si le joueur a gagner
    func isWin() -> Bool {
        for row in 0..<grideSize {
            for col in 0..<grideSize {
                if grid[row][col].value == 2048 {
                    return true
                }
            }
        }
        return false
    }

    // Fonction qui permet de savoir si le joueur a perdu
    func isLose() -> Bool {
        for row in 0..<grideSize {
            for col in 0..<grideSize {
                if grid[row][col].value == 0 {
                    return false
                }
                if row > 0 && grid[row][col].value == grid[row - 1][col].value {
                    return false
                }
                if row < grideSize - 1 && grid[row][col].value == grid[row + 1][col].value {
                    return false
                }
                if col > 0 && grid[row][col].value == grid[row][col - 1].value {
                    return false
                }
                if col < grideSize - 1 && grid[row][col].value == grid[row][col + 1].value {
                    return false
                }
            }
        }
        return true
    }

    func isFull() -> Bool {
        for row in 0..<grideSize {
            for col in 0..<grideSize {
                if grid[row][col].value == 0 {
                    return false
                }
            }
        }
        return true
    }

    // Fonction qui permet de renitialiser le jeu
    func reset() {
        for row in 0..<grideSize {
            for col in 0..<grideSize {
                grid[row][col].value = 0
                grid[row][col].tuileEvo = false
            }
        }
        generateRandomTuile()
        generateRandomTuile()
        // spawnWin()
    }

    func spawnWin() {
        grid[3][3].value = 1024
        grid[3][2].value = 512
        grid[3][1].value = 256
        grid[3][0].value = 128
        grid[2][0].value = 64
        grid[2][1].value = 32
        grid[2][2].value = 16
        grid[2][3].value = 8
        grid[1][3].value = 4
        grid[1][2].value = 2
        grid[1][1].value = 2
    }

    enum Direction {
        case up, down, left, right
    }
}
