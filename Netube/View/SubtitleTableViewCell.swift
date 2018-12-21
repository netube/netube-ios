import UIKit

class SubtitleTableViewCell: UITableViewCell {
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: .subtitle, reuseIdentifier: Idetifier.subtitleTableViewCell.rawValue)
                detailTextLabel?.font = UIFont.systemFont(ofSize: 10)
                detailTextLabel?.textColor = UIColor.gray
        }
        
        required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
                fatalError("init(coder:) has not been implemented")
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
                super.setSelected(selected, animated: animated)
        }
}
