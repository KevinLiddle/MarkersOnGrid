import UIKit

class GameController: UICollectionViewController {

  var board: Board
  var rules: TicTacToeRules
  var game: TicTacToeGame

  required init(coder aDecoder: NSCoder) {
    board = Board(dimension: 3)
    rules = TicTacToeRules(board: board)
    game = TicTacToeGame(board: board, rules: rules)

    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView!.registerClass(GridCell.self, forCellWithReuseIdentifier: "GridCell")
    collectionView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "Footer")
    collectionView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "Header")
    collectionView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "Empty")
    collectionView!.backgroundColor = Colors.BACKGROUND
    collectionView!.setTranslatesAutoresizingMaskIntoConstraints(true)
    collectionView!.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin
  }

  // click event callback for each cell
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    if rules.isOver() {
      return
    }
    
    let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GridCell

    game.makeMove(atRow: indexPath.row, column: indexPath.section)

    if !board.isEmpty(atRow: indexPath.row, column: indexPath.section) {
      cell.fillWith(board.getMarker(atRow: indexPath.row, column: indexPath.section))
    }

    if rules.hasWinner() {
      collectionView.reloadSections(NSIndexSet(index: board.dimension - 1))
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
    if indexPath.section == board.dimension - 1 && rules.isOver() {
      return renderPlayAgainButton(collectionView, indexPath: indexPath)
    }
    return collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "Empty", forIndexPath: indexPath) as! UICollectionReusableView
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSizeMake(cellLength(), cellLength())
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 0.0
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    if section < board.dimension - 1 {
      return CGSize.zeroSize
    } else {
      return CGSize(width: UIScreen.mainScreen().bounds.width, height: 100)
    }
  }

  private func renderPlayAgainButton(collectionView: UICollectionView, indexPath: NSIndexPath) -> UICollectionReusableView {
    let footer = collectionView.dequeueReusableSupplementaryViewOfKind(
      UICollectionElementKindSectionFooter,
      withReuseIdentifier: "Footer",
      forIndexPath: indexPath
    ) as! UICollectionReusableView

    let playAgain = PlayAgain(frame: collectionView.frame)

    footer.addSubview(playAgain)

    playAgain.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin

    return footer
  }

  private func cellLength() -> CGFloat {
    return smallestScreenDimension() / CGFloat(board.dimension)
  }

  private func smallestScreenDimension() -> CGFloat {
    return [UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height].reduce(CGFloat(Int.max), combine: { min($0, $1) })
  }

}