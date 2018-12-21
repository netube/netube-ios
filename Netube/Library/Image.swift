import UIKit

struct Image {
        
        static func square(color: UIColor, side: CGFloat) -> UIImage {
                return createImage(color: color, size: CGSize(width: side, height: side))
        }
        
        static func createImage(color: UIColor, size: CGSize) -> UIImage {
                let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                UIGraphicsBeginImageContextWithOptions(size, false, 0)
                color.setFill()
                UIRectFill(rect)
                let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage(named: "DataTabBarItem")!
                UIGraphicsEndImageContext()
                return image
        }
}
