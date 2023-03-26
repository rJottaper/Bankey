//
//  LocalState.swift
//  Bankey
//
//  Created by João Pedro on 25/03/23.
//

import UIKit

public class LocalState {
  private enum Keys: String {
    case hasOnboarded;
  };
  
  public static var hasOnboarded: Bool {
    get {
      return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue);
    }
    
    set(newValue) {
      UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue);
      UserDefaults.standard.synchronize();
    }
  };
}
