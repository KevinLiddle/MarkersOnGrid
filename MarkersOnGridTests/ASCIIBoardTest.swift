import UIKit
import XCTest

class ASCIIBoardTest: XCTestCase {

  func test_DisplayReturnsAnASCIIBoard() {
    var board = Board(dimension: 3)
    board.set(marker: "X", atRow: 1, column: 0)
    board.set(marker: "X", atRow: 2, column: 1)
    board.set(marker: "O", atRow: 1, column: 1)
    board.set(marker: "O", atRow: 2, column: 2)

    var expectedOutput =
      "   |   |   \n" +
      "---|---|---\n" +
      " X | O |   \n" +
      "---|---|---\n" +
      "   | X | O \n"
    var ascii = ASCIIBoard(board: board)

    XCTAssertEqual(ascii.display(), expectedOutput)
  }
}
