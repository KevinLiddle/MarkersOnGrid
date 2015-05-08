import UIKit

class GameController: UICollectionViewController {

  var board: Board
  var rules: Rules
  var game: TicTacToeGame

  required init(coder aDecoder: NSCoder) {
    board = Board(dimension: 3)
    board.set(marker: "X", atRow: 1, column: 2)
    rules = TicTacToeRules(board: board)
    game = TicTacToeGame(board: board, rules: rules)

    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView!.registerClass(GridCell.self, forCellWithReuseIdentifier: "GridCell")
    collectionView!.backgroundColor = Colors.BACKGROUND
  }

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return board.dimension
  }

  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return board.dimension
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GridCell", forIndexPath: indexPath) as! GridCell

    if !board.isEmpty(atRow: indexPath.row, column: indexPath.section) {
      let marker = board.getMarker(atRow: indexPath.row, column: indexPath.section)
      cell.fillWith(marker)
    }

    collectionView.sizeToFit()

    return cell
  }

  override func colle

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSizeMake(UIScreen.mainScreen().bounds.width / CGFloat(board.dimension), 120)
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize()
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    return CGSize()
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 0.0
  }

}