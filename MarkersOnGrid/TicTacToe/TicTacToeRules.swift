import Foundation

class TicTacToeRules: Rules {
  var board: Board

  required init(board: Board) {
    self.board = board
  }

  func getWinner() -> String {
    var backDiagonalIndices: Array<Cell> = []
    var forwardDiagonalIndices: Array<Cell> = []

    for i in 0..<board.dimension {
      var rowIndices: Array<Cell> = []
      var columnIndices: Array<Cell> = []

      for j in 0..<board.dimension {
        rowIndices.append(Cell(row: i, column: j))
        columnIndices.append(Cell(row: j, column: i))
      }

      if groupHasWinner(rowIndices) {
        return winnerForGroup(rowIndices)
      } else if groupHasWinner(columnIndices) {
        return winnerForGroup(columnIndices)
      }

      backDiagonalIndices.append(Cell(row: i, column: i))
      forwardDiagonalIndices.append(Cell(row: i, column: board.dimension - i - 1))
    }

    if groupHasWinner(backDiagonalIndices) {
      return winnerForGroup(backDiagonalIndices)
    } else if groupHasWinner(forwardDiagonalIndices) {
      return winnerForGroup(forwardDiagonalIndices)
    }

    return Board.emptyCell()
  }

  func hasWinner() -> Bool {
    return getWinner() != Board.emptyCell()
  }

  func isCatsGame() -> Bool {
    return !hasWinner() && board.isFull()
  }

  func isOver() -> Bool {
    return hasWinner() || isCatsGame()
  }

  private func groupHasWinner(group: Array<Cell>) -> Bool {
    return winnerForGroup(group) != Board.emptyCell()
  }

  private func winnerForGroup(group: Array<Cell>) -> String {
    var firstOfGroup = board.getMarker(atRow: group.first!.row, column: group.first!.column)

    return group.reduce(firstOfGroup) {
      var cell: Cell = $1

      if self.board.isEmpty(atRow: cell.row, column: cell.column) ||
        self.board.getMarker(atRow: cell.row, column: cell.column) != $0 {
        return Board.emptyCell()
      } else {
        return firstOfGroup
      }
    }
  }

  private struct Cell {
    let row: Int
    let column: Int
  }

}
