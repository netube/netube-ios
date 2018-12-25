import UIKit

extension UITableViewCell {
        func setPoint(color: UIColor, size: CGFloat) {
                imageView?.image = Image.square(color: color, side: size)
                imageView?.layer.cornerRadius = size / 2
                imageView?.clipsToBounds = true
                imageView?.layoutIfNeeded()
        }
}
