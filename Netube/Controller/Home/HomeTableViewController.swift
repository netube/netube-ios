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

final class HomeTableViewController: UITableViewController {
        
        var servers: [Configuration] = [Configuration]()
        private var selectedIndex: Int = 0
        
        override func viewWillAppear(_ animated: Bool) {
                tabBarController?.tabBar.isHidden = false
        }
        
        override func viewDidLoad() {
                super.viewDidLoad()
                title = LocalText.Home
                navigationController?.navigationBar.tintColor = UIColor.primary
                
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addServer))
                
                tableView.register(RightDetailTableViewCell.self, forCellReuseIdentifier: Idetifier.rightDetailTableViewCell.rawValue)
                tableView.register(NormalTableViewCell.self, forCellReuseIdentifier: Idetifier.normalTableViewCell.rawValue)
                tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: Idetifier.switchTableViewCell.rawValue)
                
                clearsSelectionOnViewWillAppear = true
        }
        
        @objc private func addServer() {
                navigationController?.pushViewController(AddServiceTableViewController(), animated: true)
                // navigationController?.pushViewController(AddServerTableViewController(), animated: true)
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
                return (servers.count == 0) ? 2 : 3
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                switch section {
                case 0:
                        return 1
                case 1:
                        return 1
                case 2:
                        return servers.count
                default:
                        return 1
                }
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
                switch section {
                case 0:
                        return space
                case 1:
                        return space
                case 2:
                        return "SERVERS"
                default:
                        return space
                }
        }
        override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
                switch section {
                case 0:
                        return "ICMP Ping"
                case 1:
                        return space
                case 2:
                        return space
                default:
                        return space
                }
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                switch indexPath.section {
                case 0:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.normalTableViewCell.rawValue, for: indexPath) as? NormalTableViewCell else { return UITableViewCell() }
                        cell.textLabel?.text = "Ping"
                        return cell
                case 1:
                        guard let cell  = tableView.dequeueReusableCell(withIdentifier: Idetifier.switchTableViewCell.rawValue, for: indexPath) as? SwitchTableViewCell else { return UITableViewCell() }
                        cell.textLabel?.text = LocalText.NotConnected
                        cell.switchView.addTarget(self, action: #selector(handle(switchView:)), for: UIControl.Event.touchUpInside)
                        cell.switchView.isEnabled = servers.count != 0
                        return cell
                case 2:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: Idetifier.rightDetailTableViewCell.rawValue, for: indexPath) as? RightDetailTableViewCell else { return UITableViewCell() }
                        cell.accessoryType = .detailButton
                        if servers.count >= indexPath.row {
                                cell.textLabel?.text = servers[indexPath.row].name
                        }
                        if selectedIndex == indexPath.row {
                                cell.setPoint(color: .primary, size: 8)
                        } else {
                                cell.setPoint(color: .white, size: 8)
                        }
                        return cell
                default:
                        return UITableViewCell()
                }
        }
        
        @objc private func handle(switchView: UISwitch) {
                let cell = switchView.superview as? SwitchTableViewCell
                if switchView.isOn {
                        cell?.textLabel?.text = LocalText.Connected
                } else {
                        cell?.textLabel?.text = LocalText.NotConnected
                }
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
                if indexPath.section == 2 {
                        selectedIndex = indexPath.row
                        tableView.visibleCells.forEach { cell in
                                let ip: IndexPath = tableView.indexPath(for: cell) ?? indexPath
                                if ip.section == 2 {
                                        tableView.cellForRow(at: ip)?.setPoint(color: .white, size: 8)
                                }
                        }
                        tableView.cellForRow(at: indexPath)?.setPoint(color: .primary, size: 8)
                }
        }
        
        override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
                if indexPath.section == 2 {
                        if servers.count >= indexPath.row {
                                let editServerTVC = EditServerTableViewController()
                                editServerTVC.server = servers[indexPath.row]
                                editServerTVC.serverNumber = indexPath.row
                                navigationController?.pushViewController(editServerTVC, animated: true)
                        }
                }
        }
}
