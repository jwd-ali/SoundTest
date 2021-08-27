import UIKit
extension UIView {
    func pinToSuperView() {
      guard let superview = superview else {
        return
      }
      translatesAutoresizingMaskIntoConstraints = false
      superview.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
      superview.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
      superview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      superview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
