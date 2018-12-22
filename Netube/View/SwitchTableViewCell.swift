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

class SwitchTableViewCell: UITableViewCell {
        
        let switchView: UISwitch = UISwitch()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: .default, reuseIdentifier: Idetifier.switchTableViewCell.rawValue)
                selectionStyle = .none
                accessoryView = switchView
        }
        
        required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
                fatalError("init(coder:) has not been implemented")
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
                super.setSelected(selected, animated: animated)
        }
}
