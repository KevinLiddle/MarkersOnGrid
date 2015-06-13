import UIKit

class PlayAgain: UIButton {

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setTitle("Play Again", forState: UIControlState.Normal)
    titleLabel!.font = UIFont(name: "Futura-Medium", size: 35.0)
    setTitleColor(Colors.PRIMARY_TEXT, forState: UIControlState.Normal)
    titleLabel!.textAlignment = .Center

    sizeToFit()

  }

}