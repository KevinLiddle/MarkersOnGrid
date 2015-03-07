import UIKit

class TemplateController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view = loadViewFromNib()
  }

  func loadViewFromNib() -> UIView {
    return NSBundle.mainBundle().loadNibNamed("TemplateView", owner: self, options: nil)[0] as UIView
  }

}