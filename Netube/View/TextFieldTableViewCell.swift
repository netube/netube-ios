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

class TextFieldTableViewCell: UITableViewCell {
        
        let label: UILabel = UILabel()
        let textField: UITextField = UITextField()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: .default, reuseIdentifier: Idetifier.textFieldTableViewCell.rawValue)
                selectionStyle = .none
                setupLabel()
                setupTextField()
        }
        
        required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
                fatalError("init(coder:) has not been implemented")
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
                super.setSelected(selected, animated: animated)
        }
        
        private func setupLabel() {
                contentView.addSubview(label)
                label.translatesAutoresizingMaskIntoConstraints = false
                let top: NSLayoutConstraint = NSLayoutConstraint(
                        item: label,
                        attribute: .top,
                        relatedBy: .equal,
                        toItem: contentView,
                        attribute: .topMargin,
                        multiplier: 1,
                        constant: 0
                )
                let bottom: NSLayoutConstraint = NSLayoutConstraint(
                        item: label,
                        attribute: .bottom,
                        relatedBy: .equal,
                        toItem: contentView,
                        attribute: .bottomMargin,
                        multiplier: 1,
                        constant: 0
                )
                let left: NSLayoutConstraint = NSLayoutConstraint(
                        item: label,
                        attribute: .left,
                        relatedBy: .equal,
                        toItem: contentView,
                        attribute: .leftMargin,
                        multiplier: 1,
                        constant: 0
                )
                let width: NSLayoutConstraint = NSLayoutConstraint(
                        item: label,
                        attribute: .width,
                        relatedBy: .equal,
                        toItem: contentView,
                        attribute: .width,
                        multiplier: 0.25,
                        constant: 0
                )
                contentView.addConstraints([top, bottom, left, width])
        }
        
        private func setupTextField() {
                contentView.addSubview(textField)
                textField.translatesAutoresizingMaskIntoConstraints = false
                let top: NSLayoutConstraint = NSLayoutConstraint(
                        item: textField,
                        attribute: .top,
                        relatedBy: .equal,
                        toItem: contentView,
                        attribute: .topMargin,
                        multiplier: 1,
                        constant: 0
                )
                let bottom: NSLayoutConstraint = NSLayoutConstraint(
                        item: textField,
                        attribute: .bottom,
                        relatedBy: .equal,
                        toItem: contentView,
                        attribute: .bottomMargin,
                        multiplier: 1,
                        constant: 0
                )
                let right: NSLayoutConstraint = NSLayoutConstraint(
                        item: textField,
                        attribute: .right,
                        relatedBy: .equal,
                        toItem: contentView,
                        attribute: .rightMargin,
                        multiplier: 1,
                        constant: 0
                )
                let left: NSLayoutConstraint = NSLayoutConstraint(
                        item: textField,
                        attribute: .left,
                        relatedBy: .equal,
                        toItem: label,
                        attribute: .right,
                        multiplier: 1,
                        constant: 0
                )
                contentView.addConstraints([top, bottom, right, left])
                textField.autocapitalizationType = .none
                textField.autocorrectionType = .no
                textField.borderStyle = .none
                textField.spellCheckingType = .no
                textField.returnKeyType = .next
        }
}
