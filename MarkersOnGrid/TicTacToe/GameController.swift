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
    collectionView!.backgroundColor = Colors.BACKGROUND
    centerBoard(UIScreen.mainScreen().bounds.size)
  }

  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    centerBoard(size)
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
      renderPlayAgainButton()
    } else if rules.isCatsGame() {
      // do other stuff
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

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSizeMake(cellLength(), cellLength())
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 0.0
  }

  private func renderPlayAgainButton() {
    var playAgain = NSBundle.mainBundle().loadNibNamed("PlayAgain", owner: self, options: nil)[0] as! PlayAgain
    playAgain.setTranslatesAutoresizingMaskIntoConstraints(false)
    self.view.addSubview(playAgain)
//    self.view.addConstraints([
//      NSLayoutConstraint(
//        item: playAgain,
//        attribute: NSLayoutAttribute.CenterX,
//        relatedBy: NSLayoutRelation.Equal,
//        toItem: UIScreen.mainScreen(),
//        attribute: NSLayoutAttribute.CenterX,
//        multiplier: 1.0,
//        constant: 0.0
//      ),
//      NSLayoutConstraint(
//        item: playAgain,
//        attribute: NSLayoutAttribute.Bottom,
//        relatedBy: NSLayoutRelation.LessThanOrEqual,
//        toItem: collectionView,
//        attribute: NSLayoutAttribute.Bottom,
//        multiplier: 1.0,
//        constant: -playAgain.bounds.height
//      )
//    ])
  }

  private func centerBoard(size: CGSize) {
    collectionView!.contentInset = UIEdgeInsetsMake(sidePadding(size.height), sidePadding(size.width), 0, 0)
  }

  private func sidePadding(sideDimension: CGFloat) -> CGFloat {
    return (sideDimension - smallestScreenDimension()) / 2
  }

  private func cellLength() -> CGFloat {
    return smallestScreenDimension() / CGFloat(board.dimension)
  }

  private func smallestScreenDimension() -> CGFloat {
    return [UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height].reduce(CGFloat(Int.max), combine: { min($0, $1) })
  }

}