//
//  ViewController.swift
//  Bankey
//
//  Created by João Pedro on 17/03/23.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
  func didLogin();
};

protocol LogoutDelegate: AnyObject {
  func didLogout();
};

class LoginViewController: UIViewController {
  let titleLabel = UILabel();
  let subtitleLabel = UILabel();
  let loginView = LoginView();
  let signInButton = UIButton(type: .system);
  let errorMessageLabel = UILabel();
  
  weak var delegate: LoginViewControllerDelegate?
  
  var username: String? {
    return loginView.usernameTextField.text;
  };
  
  var password: String? {
    return loginView.passwordTextField.text;
  };
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    style();
    layout();
  };
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated);
    signInButton.configuration?.showsActivityIndicator = false;
  }
};

extension LoginViewController {
  private func configureSubtitleBankey() {
  };
  
  private func style() {
    loginView.translatesAutoresizingMaskIntoConstraints = false;
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    titleLabel.textAlignment = .center;
    titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle);
    titleLabel.adjustsFontForContentSizeCategory = true;
    titleLabel.text = "Bankey";
    
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false;
    subtitleLabel.textAlignment = .center;
    subtitleLabel.adjustsFontForContentSizeCategory = true;
    subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3);
    subtitleLabel.numberOfLines = 0;
    subtitleLabel.text = "Your premium source for all things banking! Enjoy 😀";
    
    signInButton.translatesAutoresizingMaskIntoConstraints = false;
    signInButton.configuration = .filled();
    signInButton.configuration?.imagePadding = 8;
    signInButton.setTitle("Sign In", for: .normal);
    signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside);
    
    errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false;
    errorMessageLabel.textAlignment = .center;
    errorMessageLabel.textColor = .systemRed;
    errorMessageLabel.numberOfLines = 0;
    errorMessageLabel.isHidden = true;
  };
  
  private func layout() {
    view.addSubview(titleLabel);
    view.addSubview(subtitleLabel);
    view.addSubview(loginView);
    view.addSubview(signInButton);
    view.addSubview(errorMessageLabel);
    
    // Title
    NSLayoutConstraint.activate([
      subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
      titleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
    ]);
    
    // Subtitle
    NSLayoutConstraint.activate([
      loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
      subtitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
      subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
    ]);
    
    // LoginView
    NSLayoutConstraint.activate([
      loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
    ]);
    
    // Button
    NSLayoutConstraint.activate([
      signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
      signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
      signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
    ]);
    
    // Error Message
    NSLayoutConstraint.activate([
      errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
      errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
      errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
    ]);
  };
  
  @objc func signInTapped() {
    errorMessageLabel.isHidden = true;
    login();
  };
  
  private func login() {
    guard let username = username, let password = password else {
      assertionFailure("Username / Password should never be nil");
      return;
    };
    
    if username.isEmpty || password.isEmpty {
      configureView(withMessage: "Username / Password - cannot be blank");
      return;
    };
    
    if username == "Jottaper" && password == "0000" {
      signInButton.configuration?.showsActivityIndicator = true;
      delegate?.didLogin();
    } else {
      configureView(withMessage: "Incorrect username / password");
    };
  };
  
  private func configureView(withMessage message: String) {
    errorMessageLabel.text = message;
    errorMessageLabel.isHidden = false;
  };
};
