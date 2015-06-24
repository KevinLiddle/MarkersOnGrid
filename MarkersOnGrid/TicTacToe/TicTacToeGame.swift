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

  func makeMove(atRow row: Int, column: Int) {
    if board.isEmpty(atRow: row, column: column) {
      board.set(marker: currentPlayer, atRow: row, column: column)
      alternateCurrentPlayer()
    }
  }

  func reset() {
    board.reset()
    currentPlayer = player1
  }

  private func alternateCurrentPlayer() {
    if currentPlayer == player1 {
      currentPlayer = player2
    } else {
      currentPlayer = player1
    }
  }

}