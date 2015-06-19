import UIKit

class Winner: UILabel {

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  init(frame: CGRect, winner: String) {
    super.init(frame: frame)

    text = getText(winner)
    font = UIFont(name: "Futura-Medium", size: 35.0)
    textColor = Colors.PRIMARY_TEXT
    textAlignment = .Center

    sizeToFit()
  }

  func getText(winner: String) -> String {
    if winner == "" {
      return "Cat's Game"
    } else {
      return "\(winner) Wins!"
    }
  }
  
}