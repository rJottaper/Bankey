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
  
  // Animation
  var leadingEdgeOnScreen: CGFloat = 16;
  var leadingEdgeOffScreen: CGFloat = -1000;
  
  var titleLeadingAnchor: NSLayoutConstraint?
  var subtitleLeadingAnchor: NSLayoutConstraint?
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    style();
    layout();
  };
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated);
    signInButton.configuration?.showsActivityIndicator = false;
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated);
    
    animate();
    animateTextAlpha();
  };
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
    titleLabel.alpha = 0;
    
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
      titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
    ]);
    
    titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen);
    titleLeadingAnchor?.isActive = true;
    
    // Subtitle
    NSLayoutConstraint.activate([
      loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
      subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
    ]);
    
    subtitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen);
    subtitleLeadingAnchor?.isActive = true;
    
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
    shakeButton();
  };
};

// MARK: - Animations
extension LoginViewController {
  private func animate() {
    let animator1 = UIViewPropertyAnimator(duration: 0.8, curve: .easeInOut) {
      self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen;
      self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen;
      self.view.layoutIfNeeded();
    };
    animator1.startAnimation();
  };
  
  private func animateTextAlpha() {
    let animator1 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
      self.titleLabel.alpha = 1;
      self.view.layoutIfNeeded();
    };
    animator1.startAnimation(afterDelay: 0.4);
  };
  
  private func shakeButton() {
    let animation = CAKeyframeAnimation();
    animation.keyPath = "position.x";
    animation.values = [0, 10, -10, 10, 0];
    animation.keyTimes = [0, 0.16, 0.5, 0.83, 1];
    animation.duration = 0.4;

    animation.isAdditive = true;
    signInButton.layer.add(animation, forKey: "shake");
  };
};

