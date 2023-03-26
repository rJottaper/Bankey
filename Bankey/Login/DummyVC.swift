//
//  DummyVC.swift
//  Bankey
//
//  Created by João Pedro on 25/03/23.
//

import UIKit

class DummyVC: UIViewController {
  let stackView = UIStackView();
  let label = UILabel();
  let logoutButton = UIButton(type: .system);
  
  weak var logoutDelegate: LogoutDelegate?
    
  override func viewDidLoad() {
    super.viewDidLoad();
    style();
    layout();
  };
};

extension DummyVC {
  func style() {
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    stackView.axis = .vertical
    stackView.spacing = 20
    
    label.translatesAutoresizingMaskIntoConstraints = false;
    label.text = "Welcome";
    label.font = UIFont.preferredFont(forTextStyle: .title1);
    
    logoutButton.translatesAutoresizingMaskIntoConstraints = false;
    logoutButton.configuration = .filled();
    logoutButton.setTitle("Logout", for: .normal);
    logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside);
  };
    
  func layout() {
    stackView.addArrangedSubview(label);
      
    view.addSubview(stackView);
    stackView.addArrangedSubview(logoutButton);
      
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ]);
  };
  
  @objc func logoutButtonTapped() {
    logoutDelegate?.didLogout();
  };
};
