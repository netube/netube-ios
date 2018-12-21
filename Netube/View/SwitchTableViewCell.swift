import UIKit

class SwitchTableViewCell: UITableViewCell {
        
        let switchView: UISwitch = UISwitch()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: .default, reuseIdentifier: Idetifier.switchTableViewCell.rawValue)
                selectionStyle = .none
                accessoryView = switchView
        }
        
        required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
                fatalError("init(coder:) has not been implemented")
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
                super.setSelected(selected, animated: animated)
        }
}
