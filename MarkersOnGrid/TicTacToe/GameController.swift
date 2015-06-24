import UIKit

class GameController: UICollectionViewController {

  let FOOTER_TAG = 999
  let HEADER_TAG = 111

  var board: Board
  var rules: TicTacToeRules
  var game: TicTacToeGame
  var coder: NSCoder

  required init(coder aDecoder: NSCoder) {
    board = Board(dimension: 3)
    rules = TicTacToeRules(board: board)
    game = TicTacToeGame(board: board, rules: rules)
    coder = aDecoder

    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    registerSubviewClasses()

    collectionView!.backgroundColor = Colors.BACKGROUND
  }

  // click event callback for each cell
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    if !rules.isOver() {
      handleMove(collectionView, atIndexPath: indexPath)
    }
  }

  override func shouldAutorotate() -> Bool {
    return false
  }

  override func supportedInterfaceOrientations() -> Int {
    return UIInterfaceOrientation.Portrait.rawValue
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCellWithReuseIdentifier("GridCell", forIndexPath: indexPath) as! GridCell
  }

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return board.dimension
  }

  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return board.dimension
  }

  override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    if indexPath.section == 0 && kind == UICollectionElementKindSectionHeader {
      return renderHeader(collectionView, indexPath: indexPath)
    } else if indexPath.section == board.dimension - 1 && kind == UICollectionElementKindSectionFooter {
      return renderFooter(collectionView, indexPath: indexPath)
    }

    return renderEmptySection(collectionView, indexPath: indexPath, kind: kind)
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSizeMake(cellLength(), cellLength())
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 0.0
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    if section == board.dimension - 1 {
      return supplementarySectionSize()
    }
    return CGSize.zeroSize
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    if section == 0 {
      return supplementarySectionSize()
    }
    return CGSize.zeroSize
  }

  func resetGame() {
    game.reset()
    let originalCollectionView = collectionView!
    self.collectionView = UICollectionView(frame: originalCollectionView.frame, collectionViewLayout: originalCollectionView.collectionViewLayout)
    viewDidLoad()
  }

  private func handleMove(collectionView: UICollectionView, atIndexPath indexPath: NSIndexPath) {
    let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GridCell

    game.makeMove(atRow: indexPath.row, column: indexPath.section)

    if !board.isEmpty(atRow: indexPath.row, column: indexPath.section) {
      cell.fillWith(board.getMarker(atRow: indexPath.row, column: indexPath.section))
    }

    if rules.isOver() {
      renderWinner(collectionView)
      renderPlayAgain(collectionView)
    }
  }

  private func renderWinner(collectionView: UICollectionView) {
    let header = collectionView.viewWithTag(HEADER_TAG) as! UICollectionReusableView
    let winner = Winner(frame: header.frame, winner: rules.getWinner())

    header.addSubview(winner)
    center(winner, inParentView: header)
  }

  private func renderPlayAgain(collectionView: UICollectionView) {
    let footer = collectionView.viewWithTag(FOOTER_TAG) as! UICollectionReusableView
    let playAgain = PlayAgain(frame: footer.frame)

    playAgain.addTarget(self, action: "resetGame", forControlEvents: UIControlEvents.TouchUpInside)

    footer.addSubview(playAgain)
    center(playAgain, inParentView: footer)
  }

  private func renderHeader(collectionView: UICollectionView, indexPath: NSIndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryViewOfKind(
      UICollectionElementKindSectionHeader,
      withReuseIdentifier: "Header",
      forIndexPath: indexPath
      ) as! UICollectionReusableView

    header.tag = HEADER_TAG

    return header
  }

  private func renderFooter(collectionView: UICollectionView, indexPath: NSIndexPath) -> UICollectionReusableView {
    let footer = collectionView.dequeueReusableSupplementaryViewOfKind(
      UICollectionElementKindSectionFooter,
      withReuseIdentifier: "Footer",
      forIndexPath: indexPath
    ) as! UICollectionReusableView

    footer.tag = FOOTER_TAG

    return footer
  }

  private func renderEmptySection(collectionView: UICollectionView, indexPath: NSIndexPath, kind: String) -> UICollectionReusableView {
    return collectionView.dequeueReusableSupplementaryViewOfKind(
      kind,
      withReuseIdentifier: "Empty",
      forIndexPath: indexPath
      ) as! UICollectionReusableView
  }

  private func center(childView: UIView, inParentView parent: UIView) {
    childView.center = CGPoint(x: parent.bounds.width / 2, y: parent.bounds.height / 2)
  }

  private func supplementarySectionSize() -> CGSize {
    let height = (UIScreen.mainScreen().bounds.height - screenWidth()) / 3.0

    return CGSize(width: screenWidth(), height: height)
  }

  private func cellLength() -> CGFloat {
    return screenWidth() / CGFloat(board.dimension)
  }

  private func screenWidth() -> CGFloat {
    return UIScreen.mainScreen().bounds.width
  }

  private func screenHeight() -> CGFloat {
    return UIScreen.mainScreen().bounds.height
  }

  private func registerSubviewClasses() {
    collectionView!.registerClass(GridCell.self, forCellWithReuseIdentifier: "GridCell")
    collectionView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "Footer")
    collectionView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
    collectionView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "Empty")
    collectionView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Empty")
  }

}