//
//  UITextFieldSecureToggle.swift
//  Bankey
//
//  Created by João Pedro on 28/03/23.
//

import UIKit

let passwordToggleButton = UIButton(type: .custom);

extension UITextField {
  func enablePasswordToggle(){
    passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal);
    passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected);
    passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside);
    rightView = passwordToggleButton;
    rightViewMode = .always;
  };
    
  @objc func togglePasswordView(_ sender: Any) {
    isSecureTextEntry.toggle();
    passwordToggleButton.isSelected.toggle();
  };
};
