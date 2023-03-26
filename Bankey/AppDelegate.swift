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
  let dummyVC = DummyVC();
  let mainViewController = MainViewController();
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds);
    window?.makeKeyAndVisible();
    window?.backgroundColor = .systemBackground;
    
    loginViewController.delegate = self;
    onboardingContainerViewController.delegate = self;
    dummyVC.logoutDelegate = self;
    
    window?.rootViewController = AccountSummaryViewController();
    
    return true;
  };
};

extension AppDelegate: LoginViewControllerDelegate, OnboardingContainerViewControllerDelegate, LogoutDelegate {
  func didLogin() {
    if LocalState.hasOnboarded {
      setRootViewController(mainViewController);
    } else {
      setRootViewController(onboardingContainerViewController);
    };
  };
  
  func didFinishOnboarding() {
    LocalState.hasOnboarded = true;
    setRootViewController(mainViewController);
  };
  
  func didLogout() {
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

