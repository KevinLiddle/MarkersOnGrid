import UIKit

class GridCell : UICollectionViewCell {

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  var marker : UILabel!

  override init(frame: CGRect) {
    super.init(frame: frame)

    let textFrame = CGRect(x: 0, y: 32, width: frame.size.width, height: frame.size.height/3)
    marker = UILabel(frame: textFrame)
    marker.textAlignment = .Center
    contentView.addSubview(marker)
  }

}