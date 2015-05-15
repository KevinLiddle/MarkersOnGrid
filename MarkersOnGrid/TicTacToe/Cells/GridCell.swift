import UIKit

class GridCell : UICollectionViewCell {

  var marker : UILabel!

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    let textFrame = CGRect(x: 0, y: 32, width: frame.size.width, height: frame.size.height/3)
    marker = UILabel(frame: textFrame)
    marker.textAlignment = .Center
    layer.borderColor = Colors.BOARD_BORDER.CGColor
    layer.borderWidth = 2.0
    self.addSubview(marker)

    sizeToFit()
  }

  func fillWith(_marker: String) {
    marker.text = _marker
  }

}