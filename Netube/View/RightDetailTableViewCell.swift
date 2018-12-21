import UIKit

class RightDetailTableViewCell: UITableViewCell {
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: .value1, reuseIdentifier: Idetifier.rightDetailTableViewCell.rawValue)
        }
        
        required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
                fatalError("init(coder:) has not been implemented")
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
                super.setSelected(selected, animated: animated)
        }
}
