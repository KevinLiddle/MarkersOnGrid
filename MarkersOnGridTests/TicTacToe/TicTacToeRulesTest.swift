import UIKit
import XCTest

class TicTacToeRulesTest: XCTestCase {

  var board: Board!
  var tttRules: TicTacToeRules!

  override func setUp() {
    super.setUp()
    board = Board(dimension: 3)
    tttRules = TicTacToeRules(board: board)
  }

  func test_ThereIsNoWinnerOnAnEmptyBoard() {
    XCTAssertFalse(tttRules.hasWinner())
  }

  func test_ThereIsAWinnerIfAWholeRowHasTheSameMarker() {
    for column in 0..<3 {
      board.set(marker: "X", atRow: 1, column: column)
    }
    XCTAssertTrue(tttRules.hasWinner())
  }

  func test_ThereIsAWinnerIfAWholeColumnHasTheSameMarker() {
    for row in 0..<3 {
      board.set(marker: "X", atRow: row, column: 2)
    }
    XCTAssertTrue(tttRules.hasWinner())
  }

  func test_ThereIsAWinnerIfTheBackDiagonalIsAllTheSameMarker() {
    for cell in 0..<3 {
      board.set(marker: "X", atRow: cell, column: cell)
    }
    XCTAssertTrue(tttRules.hasWinner())
  }

  func test_ThereIsAWinnerIfTheForwardDiagonalIsAllTheSameMarker() {
    for cell in 0..<3 {
      board.set(marker: "X", atRow: cell, column: 2 - cell)
    }
    XCTAssertTrue(tttRules.hasWinner())
  }

  func test_GetWinnerReturnsEmptyCellIfNoWinner() {
    XCTAssertEqual(tttRules.getWinner(), Board.emptyCell())
  }

  func test_XWinsIfAWholeRowHasX() {
    for column in 0..<3 {
      board.set(marker: "X", atRow: 1, column: column)
    }
    XCTAssertEqual(tttRules.getWinner(), "X")
  }

  func test_OWinsIfAWholeColumnHasO() {
    for row in 0..<3 {
      board.set(marker: "O", atRow: row, column: 2)
    }
    XCTAssertEqual(tttRules.getWinner(), "O")
  }

  func test_YWinsIfTheBackDiagonalIsAllY() {
    for cell in 0..<3 {
      board.set(marker: "Y", atRow: cell, column: cell)
    }
    XCTAssertEqual(tttRules.getWinner(), "Y")
  }

  func test_KevinWinsIfTheBackDiagonalIsAllKevin() {
    for cell in 0..<3 {
      board.set(marker: "Kevin", atRow: cell, column: 2 - cell)
    }
    XCTAssertEqual(tttRules.getWinner(), "Kevin")
  }

}