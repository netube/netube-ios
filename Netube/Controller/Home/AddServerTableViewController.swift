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

final class AddServerTableViewController: UITableViewController, UITextFieldDelegate {
        private var fields: [UITextField] = Array(repeating: UITextField(), count: 4)
        
        var usingCipher: Cipher = .chacha20poly1305
        
        private var newServer: Configuration?
        
        override func viewWillAppear(_ animated: Bool) {
                tabBarController?.tabBar.isHidden = true
        }
        
        override func viewDidLoad() {
                super.viewDidLoad()
                title = LocalText.Host
                navigationController?.navigationBar.tintColor = UIColor.primary
                
                tableView.register(NormalTableViewCell.self, forCellReuseIdentifier: Idetifier.normalTableViewCell.rawValue)
                tableView.register(RightDetailTableViewCell.self, forCellReuseIdentifier: Idetifier.rightDetailTableViewCell.rawValue)
                tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: Idetifier.textFieldTableViewCell.rawValue)
                
                clearsSelectionOnViewWillAppear = true
                
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(confirm))
        }
        
        @objc private func confirm() {
                if (fields.filter { $0.hasCharacters }).count == fields.count {
                        newServer = Configuration(host: fields[0].text ?? "error",
                                                  port: fields[1].text.convertToInteger,
                                                  secret: fields[2].text ?? "error",
                                                  remark: fields[3].text ?? "error",
                                                  cipher: usingCipher)
                        let count: Int = navigationController?.viewControllers.count ?? 2
                        if let homeTVC = navigationController?.viewControllers[count - 2] as? HomeTableViewController {
                                homeTVC.servers.append(newServer!)
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
                return 2
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                switch section {
                case 0:
                        return 1
                case 1:
                        return 5
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
                case 1:
                        return space
                default:
                        return nil
                }
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                switch indexPath.section {
                case 0:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.normalTableViewCell.rawValue, for: indexPath) as? NormalTableViewCell else { return UITableViewCell() }
                        cell.textLabel?.text = LocalText.ScanQRCode
                        return cell
                case 1:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.textFieldTableViewCell.rawValue, for: indexPath) as? TextFieldTableViewCell else { return UITableViewCell() }
                        cell.textField.delegate = self
                        switch indexPath.row {
                        case 0:
                                cell.label.text = LocalText.Host
                                cell.textField.placeholder = LocalText.Required
                                cell.textField.keyboardType = .URL
                                fields[0] = cell.textField
                        case 1:
                                cell.label.text = LocalText.Port
                                cell.textField.placeholder = LocalText.Required
                                cell.textField.keyboardType = .numberPad
                                fields[1] = cell.textField
                        case 2:
                                cell.label.text = LocalText.Secret
                                cell.textField.placeholder = LocalText.Required
                                cell.textField.isSecureTextEntry = true
                                fields[2] = cell.textField
                        case 3:
                                cell.label.text = LocalText.Remark
                                cell.textField.placeholder = LocalText.Required
                                cell.textField.returnKeyType = .default
                                cell.textField.autocapitalizationType = .words
                                cell.textField.autocorrectionType = .yes
                                cell.textField.spellCheckingType = .yes
                                fields[3] = cell.textField
                        case 4:
                                guard let cipherCell = tableView.dequeueReusableCell(withIdentifier: Idetifier.rightDetailTableViewCell.rawValue, for: indexPath) as? RightDetailTableViewCell else { return UITableViewCell() }
                                cipherCell.textLabel?.text = LocalText.Cipher
                                cipherCell.textLabel?.textColor = UIColor.darkGray
                                cipherCell.detailTextLabel?.text = usingCipher.rawValue
                                cipherCell.accessoryType = .disclosureIndicator
                                return cipherCell
                        default:
                                break
                        }
                        return cell
                default:
                        return UITableViewCell()
                }
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
                if indexPath.section == 1 {
                        switch indexPath.row {
                        case 4:
                                let cipherTVC: CipherTableViewController = CipherTableViewController()
                                cipherTVC.selectedCipher = usingCipher
                                navigationController?.pushViewController(cipherTVC, animated: true)
                        default:
                                break
                        }
                }
        }
}
