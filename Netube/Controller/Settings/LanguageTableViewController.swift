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

final class LanguageTableViewController: UITableViewController {
        
        enum Language: String {
                case english = "English"
                case cantonese = "粵語"
                case mandarinChinese = "國語"
                case mandarinPutonghuaTraditionalChinese = "普通話 - 傳統漢字"
                case mandarinPutonghuaSimplifiedChinese = "普通话 - 简化字"
        }
        
        var selectedLanguage: Language = .english
        
        override func viewWillAppear(_ animated: Bool) {
                tabBarController?.tabBar.isHidden = true
        }
        
        override func viewWillDisappear(_ animated: Bool) {
                tabBarController?.tabBar.isHidden = false
        }
        
        override func viewDidLoad() {
                super.viewDidLoad()
                title = LocalText.Language
                navigationController?.navigationBar.tintColor = UIColor.primary
                
                tableView.register(NormalTableViewCell.self, forCellReuseIdentifier: Idetifier.normalTableViewCell.rawValue)
                tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: Idetifier.subtitleTableViewCell.rawValue)
                
                clearsSelectionOnViewWillAppear = true
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
                return 1
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return 5
        }
        
        private let space: String = " "
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                return space
        }
        
        override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
                return space
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.subtitleTableViewCell.rawValue, for: indexPath) as? SubtitleTableViewCell else { return UITableViewCell() }
                switch indexPath.row {
                case 0:
                        cell.textLabel?.text = Language.english.rawValue
                        cell.detailTextLabel?.text = "English"
                case 1:
                        cell.textLabel?.text = Language.cantonese.rawValue
                        cell.detailTextLabel?.text = "Cantonese"
                case 2:
                        cell.textLabel?.text = Language.mandarinChinese.rawValue
                        cell.detailTextLabel?.text = "Mandarin Chinese (Traditional - Taiwan)"
                case 3:
                        cell.textLabel?.text = Language.mandarinPutonghuaTraditionalChinese.rawValue
                        cell.detailTextLabel?.text = "Mandarin Chinese (Traditional - China)"
                case 4:
                        cell.textLabel?.text = Language.mandarinPutonghuaSimplifiedChinese.rawValue
                        cell.detailTextLabel?.text = "Mandarin Chinese (Simplified)"
                default:
                        break
                }
                if cell.textLabel?.text == selectedLanguage.rawValue {
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
                        selectedLanguage = .english
                case 1:
                        selectedLanguage = .cantonese
                case 2:
                        selectedLanguage = .mandarinChinese
                case 3:
                        selectedLanguage = .mandarinPutonghuaTraditionalChinese
                case 4:
                        selectedLanguage = .mandarinPutonghuaSimplifiedChinese
                default:
                        break
                }
                performLanguageChange()
        }
        private func performLanguageChange() {
                let count: Int = navigationController?.viewControllers.count ?? 2
                let settingsTVC: SettingsTableViewController? = navigationController?.viewControllers[count - 2] as? SettingsTableViewController
                settingsTVC?.usingLanguage = selectedLanguage
                settingsTVC?.tableView.reloadData()
                navigationController?.popViewController(animated: true)
        }
}
