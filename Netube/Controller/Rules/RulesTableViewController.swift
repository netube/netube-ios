import UIKit

class RulesTableViewController: UITableViewController {
        
        override func viewDidLoad() {
                super.viewDidLoad()
                title = LocalText.Rules
                navigationController?.navigationBar.tintColor = UIColor.primary
                
                clearsSelectionOnViewWillAppear = true
                tableView.register(NormalTableViewCell.self, forCellReuseIdentifier: Idetifier.normalTableViewCell.rawValue)
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
                return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return 1
        }
        
        override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
                guard let header = view as? UITableViewHeaderFooterView else { return }
                header.textLabel?.font = UIFont.systemFont(ofSize: 11)
        }
        override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
                guard let footer = view as? UITableViewHeaderFooterView else { return }
                footer.textLabel?.font = UIFont.systemFont(ofSize: 11)
        }
        
        private let space: String = " "
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                return "Rules"
        }
        override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
                return space
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.normalTableViewCell.rawValue, for: indexPath) as? NormalTableViewCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                switch indexPath.row {
                case 0:
                        cell.textLabel?.text = "No Rules"
                        return cell
                default:
                        return UITableViewCell()
                }
        }
}
