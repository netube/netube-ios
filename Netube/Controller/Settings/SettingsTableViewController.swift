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

final class SettingsTableViewController: UITableViewController {
        
        var usingLanguage: LanguageTableViewController.Language = .english
        
        override func viewDidLoad() {
                super.viewDidLoad()
                title = LocalText.Settings
                navigationController?.navigationBar.tintColor = UIColor.primary
                
                tableView.register(NormalTableViewCell.self, forCellReuseIdentifier: Idetifier.normalTableViewCell.rawValue)
                tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: Idetifier.switchTableViewCell.rawValue)
                tableView.register(RightDetailTableViewCell.self, forCellReuseIdentifier: Idetifier.rightDetailTableViewCell.rawValue)
                
                clearsSelectionOnViewWillAppear = true
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
                return 4
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
                return space
        }
        override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
                switch section {
                case 3:
                        return space
                default:
                        return nil
                }
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                switch indexPath.section {
                case 0:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.rightDetailTableViewCell.rawValue, for: indexPath) as? RightDetailTableViewCell else { return UITableViewCell() }
                        cell.textLabel?.text = LocalText.Language
                        cell.detailTextLabel?.text = usingLanguage.rawValue
                        cell.accessoryType = .disclosureIndicator
                        return cell
                case 1:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.normalTableViewCell.rawValue, for: indexPath) as? NormalTableViewCell else { return UITableViewCell() }
                        cell.accessoryType = .disclosureIndicator
                        cell.textLabel?.text = LocalText.Help
                        return cell
                case 2:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.normalTableViewCell.rawValue, for: indexPath) as? NormalTableViewCell else { return UITableViewCell() }
                        cell.accessoryType = .disclosureIndicator
                        cell.textLabel?.text = LocalText.Privacy
                        return cell
                case 3:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.normalTableViewCell.rawValue, for: indexPath) as? NormalTableViewCell else { return UITableViewCell() }
                        cell.accessoryType = .disclosureIndicator
                        cell.textLabel?.text = LocalText.About
                        return cell
                default:
                        return UITableViewCell()
                }
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                switch indexPath.section {
                case 0:
                        let languageTVC: LanguageTableViewController = LanguageTableViewController()
                        languageTVC.selectedLanguage = usingLanguage
                        navigationController?.pushViewController(languageTVC, animated: true)
                case 2:
                        navigationController?.pushViewController(PrivacyTableViewController(), animated: true)
                case 3:
                        navigationController?.pushViewController(AboutTableViewController(), animated: true)
                default:
                        tableView.deselectRow(at: indexPath, animated: true)
                }
        }
}
