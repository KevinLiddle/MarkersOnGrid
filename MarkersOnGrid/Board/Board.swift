import Foundation

class Board {
  var dimension: Int
  var cells: Array<Array<String>>

  init(dimension: Int) {
    self.dimension = dimension
    self.cells = Board.buildCells(dimension)
  }

  func set(#marker: String, atRow row: Int, column: Int) {
    cells[row][column] = marker
  }

  func getMarker(atRow row: Int, column: Int) -> String {
    return cells[row][column]
  }

  func isEmpty(atRow row: Int, column: Int) -> Bool {
    return getMarker(atRow: row, column: column).isEmpty
  }

  func isFull() -> Bool {
    for row in 0..<dimension {
      var emptyCount = cells[row].filter({ $0 == Board.emptyCell() }).count

      if emptyCount > 0 { return false }
    }

    return true
  }

  func reset() {
    self.cells = Board.buildCells(dimension)
  }

  class func emptyCell() -> String {
    return ""
  }

  private class func buildCells(dimension: Int) -> Array<Array<String>> {
    var cells = [Array<String>]()
    for _ in 0..<dimension {
      cells.append(Board.buildRow(dimension))
    }
    return cells
  }

  private class func buildRow(dimension: Int) -> Array<String> {
    return [String](count: dimension, repeatedValue: emptyCell())
  }

}
