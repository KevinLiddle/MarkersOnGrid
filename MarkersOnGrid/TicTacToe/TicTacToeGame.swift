import Foundation

class TicTacToeGame {

  let player1 = "X"
  let player2 = "O"
  var board: Board
  var rules: Rules
  var currentPlayer: String

  init(board: Board, rules: Rules) {
    self.board = board
    self.rules = rules
    self.currentPlayer = player1
  }

  func hasWinner() -> Bool {
    return rules.hasWinner()
  }

  func makeMove(atRow row: Int, column: Int) {
    board.set(marker: currentPlayer, atRow: row, column: column)
  }

  private func alternateCurrentPlayer() {
    if currentPlayer == player1 {
      currentPlayer = player2
    } else {
      currentPlayer = player1
    }
  }

}