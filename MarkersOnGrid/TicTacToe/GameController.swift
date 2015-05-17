import UIKit

class GameController: UICollectionViewController {

  var board: Board
  var rules: Rules
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
    collectionView!.backgroundColor = Colors.BACKGROUND
    collectionView!.contentInset = UIEdgeInsetsMake(topPadding(), leftPadding(), 0, 0)
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCellWithReuseIdentifier("GridCell", forIndexPath: indexPath) as! GridCell
  }

  // click event callback for each cell
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GridCell

    game.makeMove(atRow: indexPath.row, column: indexPath.section)

    if !board.isEmpty(atRow: indexPath.row, column: indexPath.section) {
      cell.fillWith(board.getMarker(atRow: indexPath.row, column: indexPath.section))
    }
  }

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return board.dimension
  }

  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return board.dimension
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSizeMake(cellLength(), cellLength())
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 0.0
  }

  private func topPadding() -> CGFloat {
    return (UIScreen.mainScreen().bounds.height - smallestScreenDimension()) / 2
  }

  private func leftPadding() -> CGFloat {
    return (UIScreen.mainScreen().bounds.width - smallestScreenDimension()) / 2
  }

  private func cellLength() -> CGFloat {
    return smallestScreenDimension() / CGFloat(board.dimension)
  }

  private func smallestScreenDimension() -> CGFloat {
    return [UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height].reduce(CGFloat(Int.max), combine: { min($0, $1) })
  }

}