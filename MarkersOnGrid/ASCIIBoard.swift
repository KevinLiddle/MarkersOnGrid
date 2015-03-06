import Foundation

class ASCIIBoard {

  var board: Board

  init(board: Board) {
    self.board = board
  }

  func display() -> String {
    let indices = Array(0..<self.board.dimension)
    
    return indices.reduce("") { (output: String, row: Int) -> String in
      var rowOutput = indices.reduce(output, self.buildCellForRow(row)) + "\n"

      if !self.edgeOfBoard(row) {
        return rowOutput + indices.reduce("", self.buildRowSeparator) + "\n"
      }

      return rowOutput
    }
  }

  private func buildCellForRow(row: Int) -> (String, Int) -> String {
    func buildCell(accumulator: String, column: Int) -> String {
      return accumulator + displayCell(row: row, column: column)
    }
    return buildCell
  }

  private func buildRowSeparator(rowSeparator: String, column: Int) -> String {
    return "\(rowSeparator)---\(displayRightSide(column))"
  }

  private func displayCell(# row: Int, column: Int) -> String {
    return " \(self.displayMarker(row: row, column: column)) \(self.displayRightSide(column))"
  }

  private func displayMarker(# row: Int, column: Int) -> String {
    if board.isEmpty(atRow: row, column: column) {
      return " "
    }
    return board.getMarker(atRow: row, column: column)
  }

  private func displayRightSide(column: Int) -> String {
    if edgeOfBoard(column) {
      return ""
    }
    return "|"
  }

  private func edgeOfBoard(dimension: Int) -> Bool {
    return dimension == (board.dimension - 1)
  }
  
}