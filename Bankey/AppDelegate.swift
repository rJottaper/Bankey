//
//  AppDelegate.swift
//  Bankey
//
//  Created by João Pedro on 17/03/23.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  let loginViewController = LoginViewController();
  let onboardingContainerViewController = OnboardingContainerViewController();
  let mainViewController = MainViewController();
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds);
    window?.makeKeyAndVisible();
    window?.backgroundColor = .systemBackground;
    
    loginViewController.delegate = self;
    onboardingContainerViewController.delegate = self;
    
    displayLogin();
    registerForNotifications();
    return true;
  };
  
  private func displayLogin() {
    setRootViewController(loginViewController);
  };
  
  private func registerForNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil);
  };
  
  private func displayNextScreen() {
    if LocalState.hasOnboarded {
      prepareMainView();
      setRootViewController(mainViewController);
    } else {
      setRootViewController(onboardingContainerViewController);
    };
  };
  
  private func prepareMainView() {
    mainViewController.setStatusBar();
    UINavigationBar.appearance().isTranslucent = false;
    UINavigationBar.appearance().backgroundColor = appColor;
  };
};

extension AppDelegate: LoginViewControllerDelegate, OnboardingContainerViewControllerDelegate, LogoutDelegate {
  func didLogin() {
    displayNextScreen();
  };
  
  func didFinishOnboarding() {
    LocalState.hasOnboarded = true;
    prepareMainView();
    setRootViewController(mainViewController);
  };
  
  @objc func didLogout() {
    setRootViewController(loginViewController);
  };
};

extension AppDelegate {
  func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
    guard animated, let window = self.window else {
      self.window?.rootViewController = vc;
      self.window?.makeKeyAndVisible();
      return
    };
    
    window.rootViewController = vc;
    window.makeKeyAndVisible();
    UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil);
  };
};

