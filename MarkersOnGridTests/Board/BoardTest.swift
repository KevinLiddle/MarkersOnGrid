import UIKit
import XCTest

class BoardTest: XCTestCase {

  let board = Board(dimension: 3)

  func test_BoardIsInitializedWithASquareBoardWithEmptyStrings() {
    for row in 0..<3 {
      for column in 0..<3 {
        XCTAssertEqual(board.getMarker(atRow: row, column: column), "")
      }
    }
  }

  func test_BoardCanPlaceAMarkerOnACell() {
    board.set(marker: "X", atRow: 0, column: 2)
    XCTAssertEqual(board.getMarker(atRow: 0, column: 2), "X")
  }

  func test_BoardKnowsIfCellIsEmpty() {
    XCTAssertTrue(board.isEmpty(atRow: 0, column: 1))
    board.set(marker: "X", atRow: 0, column: 1)
    XCTAssertFalse(board.isEmpty(atRow: 0, column: 1))
  }

  func test_BoardKnowsIfItIsFull() {
    XCTAssertFalse(board.isFull())

    for column in 0..<board.dimension {
      board.set(marker: "X", atRow: 0, column: column)
    }
    XCTAssertFalse(board.isFull())

    for column in 0..<board.dimension {
      board.set(marker: "X", atRow: 1, column: column)
    }
    XCTAssertFalse(board.isFull())

    for column in 0..<board.dimension {
      board.set(marker: "X", atRow: 2, column: column)
    }
    XCTAssertTrue(board.isFull())
  }

}
