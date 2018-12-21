import UIKit

final class CipherTableViewController: UITableViewController {
        
        var selectedCipher: Cipher = .chacha20poly1305
        
        override func viewWillAppear(_ animated: Bool) {
                tabBarController?.tabBar.isHidden = true
        }
        
        override func viewDidLoad() {
                super.viewDidLoad()
                title = LocalText.Cipher
                navigationController?.navigationBar.tintColor = UIColor.primary
                
                tableView.register(NormalTableViewCell.self, forCellReuseIdentifier: Idetifier.normalTableViewCell.rawValue)
                clearsSelectionOnViewWillAppear = true
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
                return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return 3
        }
        
        private let space: String = " "
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                return space
        }
        override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
                return space
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.normalTableViewCell.rawValue, for: indexPath) as? NormalTableViewCell else { return UITableViewCell() }
                switch indexPath.row {
                case 0:
                        cell.textLabel?.text = Cipher.chacha20poly1305.rawValue
                case 1:
                        cell.textLabel?.text = Cipher.aes256gcm.rawValue
                case 2:
                        cell.textLabel?.text = Cipher.aes128gcm.rawValue
                default:
                        break
                }
                if cell.textLabel?.text == selectedCipher.rawValue {
                        cell.accessoryType = .checkmark
                }
                return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.visibleCells.forEach{ $0.accessoryType = .none }
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                tableView.deselectRow(at: indexPath, animated: true)
                switch indexPath.row {
                case 0:
                        selectedCipher = .chacha20poly1305
                case 1:
                        selectedCipher = .aes256gcm
                case 2:
                        selectedCipher = .aes128gcm
                default:
                        break
                }
                let count: Int = navigationController?.viewControllers.count ?? 2
                if let addServerTVC = navigationController?.viewControllers[count - 2] as? AddServerTableViewController {
                        addServerTVC.usingCipher = selectedCipher
                        addServerTVC.tableView.reloadData()
                        navigationController?.popToViewController(addServerTVC, animated: true)
                } else if let editServerTVC = navigationController?.viewControllers[count - 2] as? EditServerTableViewController {
                        editServerTVC.configuration?.cipher = selectedCipher
                        editServerTVC.usingCipher = selectedCipher
                        editServerTVC.tableView.reloadData()
                        navigationController?.popToViewController(editServerTVC, animated: true)
                }
        }
}
