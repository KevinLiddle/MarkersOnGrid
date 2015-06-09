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
    marker.font = UIFont(name: "Futura-Medium", size: 80.0)
    marker.textColor = Colors.PRIMARY_TEXT
    layer.borderColor = Colors.PRIMARY_CONTRAST.CGColor
    layer.borderWidth = 2.0
    addSubview(marker)

    sizeToFit()
  }

  func fillWith(_marker: String) {
    marker.text = _marker
  }

}