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
    let marker = board.getMarker(atRow: indexPath.row, column: indexPath.section)

    var cell = collectionView.dequeueReusableCellWithReuseIdentifier("GridCell", forIndexPath: indexPath) as! GridCell
    cell.backgroundColor = Colors.BACKGROUND

    if !board.isEmpty(atRow: indexPath.row, column: indexPath.section) {
      cell = collectionView.dequeueReusableCellWithReuseIdentifier("GridCell", forIndexPath: indexPath) as! GridCell
      cell.marker.text = marker
    }

    return cell
  }

}