import UIKit

class GridCell : UICollectionViewCell {

  var marker : UILabel!

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    marker = UILabel(frame: frame)
    marker.textAlignment = .Center
    marker.frame = contentView.bounds
    marker.font = UIFont(name: "GeezaPro-Bold", size: 50.0)
    layer.borderColor = Colors.BOARD_BORDER.CGColor
    layer.borderWidth = 2.0
    addSubview(marker)

    sizeToFit()
  }

  func fillWith(_marker: String) {
    marker.text = _marker
  }

}