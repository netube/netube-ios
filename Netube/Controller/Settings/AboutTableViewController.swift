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
import StoreKit
import SafariServices

final class AboutTableViewController: UITableViewController {
        
        override func viewWillAppear(_ animated: Bool) {
                tabBarController?.tabBar.isHidden = true
        }
        override func viewWillDisappear(_ animated: Bool) {
                tabBarController?.tabBar.isHidden = false
        }
        
        override func viewDidLoad() {
                super.viewDidLoad()
                title = LocalText.About
                navigationController?.navigationBar.tintColor = UIColor.primary
                
                tableView.register(NormalTableViewCell.self, forCellReuseIdentifier: Idetifier.normalTableViewCell.rawValue)
                tableView.register(RightDetailTableViewCell.self, forCellReuseIdentifier: Idetifier.rightDetailTableViewCell.rawValue)
                tableView.register(GradientTableViewCell.self, forCellReuseIdentifier: Idetifier.gradientTableViewCell.rawValue)
                
                clearsSelectionOnViewWillAppear = true
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
                return 5
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                switch section {
                case 0:
                        // Version
                        return 1
                case 1:
                        // Source code, website, loopool
                        return 3
                case 2:
                        // ToS and Privacy
                        return 2
                case 3:
                        // Review and Share
                        return 2
                case 4:
                        // Made by Cantonese in Cantonia
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
                case 4:
                        return space
                default:
                        return nil
                }
        }
        
        private let tinyViewForShareAction: UIView = UIView()
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                switch indexPath.section {
                case 0:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.rightDetailTableViewCell.rawValue, for: indexPath) as? RightDetailTableViewCell else { return UITableViewCell() }
                        cell.textLabel?.text = LocalText.Version
                        cell.detailTextLabel?.text = "1.0.0"
                        cell.selectionStyle = .none
                        return cell
                case 1:
                        switch indexPath.row {
                        case 0:
                                guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.rightDetailTableViewCell.rawValue, for: indexPath) as? RightDetailTableViewCell else { return UITableViewCell() }
                                cell.textLabel?.text = LocalText.SourceCode
                                cell.detailTextLabel?.text = "↗︎"
                                return cell
                        case 1:
                                guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.rightDetailTableViewCell.rawValue, for: indexPath) as? RightDetailTableViewCell else { return UITableViewCell() }
                                cell.textLabel?.text = LocalText.Website
                                cell.detailTextLabel?.text = "↗︎"
                                return cell
                        case 2:
                                guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.rightDetailTableViewCell.rawValue, for: indexPath) as? RightDetailTableViewCell else { return UITableViewCell() }
                                cell.textLabel?.text = LocalText.NetubeOnLoopool
                                cell.detailTextLabel?.text = "↗︎"
                                return cell
                        default:
                                return UITableViewCell()
                        }
                case 2:
                        switch indexPath.row {
                        case 0:
                                guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.rightDetailTableViewCell.rawValue, for: indexPath) as? RightDetailTableViewCell else { return UITableViewCell() }
                                cell.textLabel?.text = LocalText.TermsOfUse
                                cell.detailTextLabel?.text = "↗︎"
                                return cell
                        case 1:
                                guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.rightDetailTableViewCell.rawValue, for: indexPath) as? RightDetailTableViewCell else { return UITableViewCell() }
                                cell.textLabel?.text = LocalText.PrivacyPolicy
                                cell.detailTextLabel?.text = "↗︎"
                                return cell
                        default:
                                return UITableViewCell()
                        }
                case 3:
                        switch indexPath.row {
                        case 0:
                                guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.normalTableViewCell.rawValue, for: indexPath) as? NormalTableViewCell else { return UITableViewCell() }
                                cell.textLabel?.text = LocalText.ReviewThisApp
                                return cell
                        case 1:
                                guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.normalTableViewCell.rawValue, for: indexPath) as? NormalTableViewCell else { return UITableViewCell() }
                                cell.textLabel?.text = LocalText.ShareThisApp
                                tinyViewForShareAction.center.x = view.center.x
                                tinyViewForShareAction.center.y = cell.center.y
                                cell.addSubview(tinyViewForShareAction)
                                return cell
                        default:
                                return UITableViewCell()
                        }
                case 4:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.normalTableViewCell.rawValue, for: indexPath) as? NormalTableViewCell else { return UITableViewCell() }
                        cell.textLabel?.text = LocalText.MadeByCantoneseInCantonia
                        cell.textLabel?.textAlignment = .center
                        cell.textLabel?.textColor = UIColor.darkGray
                        return cell
                default:
                        return UITableViewCell()
                }
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
                switch indexPath.section {
                case 1:
                        switch indexPath.row {
                        case 0:
                                let sourceCode: URL = URL.new("https://netube.org/sources/ios")
                                open(url: sourceCode)
                        case 1:
                                let netubeWebsite: URL = URL.new("https://netube.org")
                                open(url: netubeWebsite)
                        case 2:
                                openLoopool()
                        default:
                                break
                        }
                case 2:
                        switch indexPath.row {
                        case 0:
                                let terms: URL = URL.new("https://netube.org/terms/ios")
                                open(url: terms)
                        case 1:
                                let privacyPolicy: URL = URL.new("https://netube.org/privacy/ios")
                                open(url: privacyPolicy)
                        default:
                                break
                        }
                case 3:
                        switch indexPath.row {
                        case 0:
                                SKStoreReviewController.requestReview()
                        case 1:
                                shareThisApp(sourceView: tinyViewForShareAction)
                        default:
                                break
                        }
                case 4:
                        let cantoniaWebsite: URL = URL.new("https://cantonia.org")
                        open(url: cantoniaWebsite)
                default:
                        break
                }
        }
        
        private func shareThisApp(sourceView: UIView?) {
                let url: URL = URL.new("https://netube.org/download/ios")
                let activity: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                activity.popoverPresentationController?.sourceView = sourceView
                present(activity, animated: true, completion: nil)
        }
        
        private func openLoopool() {
                let username: String = "netube"
                let loopoolURL: URL = URL.new("loopool://user?username=\(username)")
                let webURL: URL = URL.new("https://loopool.com/\(username)")
                if UIApplication.shared.canOpenURL(loopoolURL) {
                        UIApplication.shared.open(loopoolURL, options: [:], completionHandler: nil)
                } else {
                        open(url: webURL)
                }
        }
        private func openTwitter() {
                let screenName: String = "NetubeApp"
                let twitterURL: URL = URL.new("twitter://user?screen_name=\(screenName)")
                let webURL: URL = URL.new("https://twitter.com/\(screenName)")
                if UIApplication.shared.canOpenURL(twitterURL) {
                        UIApplication.shared.open(twitterURL, options: [:], completionHandler: nil)
                } else {
                        open(url: webURL)
                }
        }
        
        private func open(url: URL) {
                let safari: SFSafariViewController = SFSafariViewController(url: url)
                present(safari, animated: true, completion: nil)
        }
}
