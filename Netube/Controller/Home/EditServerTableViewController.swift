//
// -------------------------------------------------------------------------
// Copyright 2018 Bing Djeung
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// -------------------------------------------------------------------------
//

import UIKit

final class EditServerTableViewController: UITableViewController, UITextFieldDelegate {
        
        private var fields: [UITextField] = Array(repeating: UITextField(), count: 4)
        
        var serverNumber: Int?
        var server: Configuration?
        
        override func viewWillAppear(_ animated: Bool) {
                tabBarController?.tabBar.isHidden = true
        }
        
        override func viewDidLoad() {
                super.viewDidLoad()
                title = LocalText.EditServer
                navigationController?.navigationBar.tintColor = UIColor.primary
                
                tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: Idetifier.textFieldTableViewCell.rawValue)
                tableView.register(RightDetailTableViewCell.self, forCellReuseIdentifier: Idetifier.rightDetailTableViewCell.rawValue)
                tableView.register(NormalTableViewCell.self, forCellReuseIdentifier: Idetifier.normalTableViewCell.rawValue)
                
                clearsSelectionOnViewWillAppear = true
                
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(confirm))
        }
        
        @objc private func confirm() {
                if (fields.filter { $0.hasCharacters }).count == fields.count {
                        server?.host = fields[0].text ?? "error"
                        server?.port = fields[1].text.convertToInteger
                        server?.secret = fields[2].text ?? "error"
                        server?.remark = fields[3].text ?? "error"
                        let count: Int = navigationController?.viewControllers.count ?? 2
                        if let homeTVC = navigationController?.viewControllers[count - 2] as? HomeTableViewController {
                                homeTVC.servers[serverNumber!] = server!
                                homeTVC.tableView.reloadData()
                                navigationController?.popToViewController(homeTVC, animated: true)
                        }
                } else {
                        showAlert()
                }
        }
        
        private func showAlert() {
                let alert = UIAlertController(title: "Error", message: "Please don't leave any field empty", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: LocalText.Dismiss, style: .cancel, handler: nil)
                alert.addAction(dismiss)
                present(alert, animated: true, completion: nil)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                switch textField {
                case fields[0]:
                        fields[1].becomeFirstResponder()
                case fields[1]:
                        fields[2].becomeFirstResponder()
                case fields[2]:
                        fields[3].becomeFirstResponder()
                case fields[3]:
                        textField.resignFirstResponder()
                default:
                        textField.resignFirstResponder()
                }
                return true
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                view.endEditing(true)
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
                return 3
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                switch section {
                case 0:
                        return 4
                case 1:
                        return 3
                case 2:
                        return 1
                default:
                        return 1
                }
        }
        
        private let space: String = " "
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                return space
        }
        override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
                switch section {
                case 2:
                        return space
                default:
                        return nil
                }
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                switch indexPath.section {
                case 0:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.textFieldTableViewCell.rawValue, for: indexPath) as? TextFieldTableViewCell else { return UITableViewCell() }
                        cell.textField.delegate = self
                        switch indexPath.row {
                        case 0:
                                cell.label.text = LocalText.Host
                                cell.textField.text = server?.host
                                cell.textField.placeholder = LocalText.Required
                                cell.textField.keyboardType = .URL
                                fields[0] = cell.textField
                        case 1:
                                cell.label.text = LocalText.Port
                                cell.textField.text = server?.port.description
                                cell.textField.placeholder = LocalText.Required
                                cell.textField.keyboardType = .numberPad
                                fields[1] = cell.textField
                        case 2:
                                cell.label.text = LocalText.Secret
                                cell.textField.text = server?.secret
                                cell.textField.placeholder = LocalText.Required
                                cell.textField.isSecureTextEntry = true
                                fields[2] = cell.textField
                        case 3:
                                cell.label.text = LocalText.Remark
                                cell.textField.text = server?.remark
                                cell.textField.placeholder = LocalText.Required
                                cell.textField.returnKeyType = .default
                                cell.textField.autocapitalizationType = .words
                                cell.textField.autocorrectionType = .yes
                                cell.textField.spellCheckingType = .yes
                                fields[3] = cell.textField
                        default:
                                break
                        }
                        return cell
                case 1:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.rightDetailTableViewCell.rawValue, for: indexPath) as? RightDetailTableViewCell else { return UITableViewCell() }
                        switch indexPath.row {
                        case 0:
                                cell.textLabel?.text = LocalText.Cipher
                                cell.detailTextLabel?.text = server?.cipher.rawValue
                                cell.accessoryType = .disclosureIndicator
                        case 1:
                                cell.textLabel?.text = LocalText.Hash
                                cell.detailTextLabel?.text = server?.hash.rawValue
                                cell.accessoryType = .disclosureIndicator
                        case 2:
                                cell.textLabel?.text = LocalText.KeyExchange
                                cell.detailTextLabel?.text = server?.keyExchange.rawValue
                                cell.accessoryType = .disclosureIndicator
                        default:
                                break
                        }
                        return cell
                case 2:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.normalTableViewCell.rawValue, for: indexPath) as? NormalTableViewCell else { return UITableViewCell() }
                        cell.textLabel?.text = LocalText.GenerateQRCode
                        return cell
                default:
                        return UITableViewCell()
                }
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
                
                let row: Int = indexPath.section == 1 ? indexPath.row : 64
                
                switch row {
                case 0:
                        let cipherTVC = CipherTableViewController()
                        cipherTVC.selectedCipher = server?.cipher ?? .XCHACHA20_POLY1305
                        navigationController?.pushViewController(cipherTVC, animated: true)
                case 1:
                        let hashTVC = HashTableViewController()
                        hashTVC.selectedHash = server?.hash ?? .SHA2_256
                        navigationController?.pushViewController(hashTVC, animated: true)
                case 2:
                        let keyExchangeTVC = KeyExchangeTableViewController()
                        keyExchangeTVC.selectedKeyExchange = server?.keyExchange ?? .X25519
                        navigationController?.pushViewController(keyExchangeTVC, animated: true)
                default:
                        break
                }
        }
}
