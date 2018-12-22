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
import SafariServices

final class PrivacyTableViewController: UITableViewController {
        
        override func viewWillAppear(_ animated: Bool) {
                tabBarController?.tabBar.isHidden = true
        }
        override func viewWillDisappear(_ animated: Bool) {
                tabBarController?.tabBar.isHidden = false
        }
        
        override func viewDidLoad() {
                super.viewDidLoad()
                title = LocalText.Privacy
                navigationController?.navigationBar.tintColor = UIColor.primary
                
                tableView.register(RightDetailTableViewCell.self, forCellReuseIdentifier: Idetifier.rightDetailTableViewCell.rawValue)
                self.clearsSelectionOnViewWillAppear = true
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
                return 2
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
                case 0:
                        return "We do not collect personal data"
                case 1:
                        return "Netube is fully open source"
                default:
                        return space
                }
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                switch indexPath.section {
                case 0:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.rightDetailTableViewCell.rawValue, for: indexPath) as? RightDetailTableViewCell else { return UITableViewCell() }
                        cell.textLabel?.text = LocalText.PrivacyPolicy
                        cell.detailTextLabel?.text = "↗︎"
                        return cell
                case 1:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.rightDetailTableViewCell.rawValue, for: indexPath) as? RightDetailTableViewCell else { return UITableViewCell() }
                        cell.textLabel?.text = LocalText.SourceCode
                        cell.detailTextLabel?.text = "↗︎"
                        return cell
                default:
                        return UITableViewCell()
                }
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
                switch indexPath.section {
                case 0:
                        let privacyPolicy: URL = URL.new("https://netube.org/privacy/ios")
                        open(url: privacyPolicy)
                case 1:
                        let sourceCode: URL = URL.new("https://netube.org/sources/ios")
                        open(url: sourceCode)
                default:
                        break
                }
        }
        
        private func open(url: URL) {
                let safari: SFSafariViewController = SFSafariViewController(url: url)
                present(safari, animated: true, completion: nil)
        }
}
