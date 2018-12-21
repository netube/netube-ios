import UIKit

class DataTableViewController: UITableViewController {
        override func viewDidLoad() {
                super.viewDidLoad()
                title = LocalText.Data
                navigationController?.navigationBar.tintColor = UIColor.primary
                
                clearsSelectionOnViewWillAppear = true
                tableView.register(RightDetailTableViewCell.self, forCellReuseIdentifier: Idetifier.rightDetailTableViewCell.rawValue)
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
                return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return 2
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
                return "Data usage"
        }
        override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
                return space
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.rightDetailTableViewCell.rawValue, for: indexPath) as? RightDetailTableViewCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                switch indexPath.row {
                case 0:
                        cell.textLabel?.text = "Sent"
                        cell.detailTextLabel?.text = "0 Bytes"
                        return cell
                case 1:
                        cell.textLabel?.text = "Recived"
                        cell.detailTextLabel?.text = "0 Bytes"
                        return cell
                default:
                        return UITableViewCell()
                }
        }
}
