//
//  DecimalUtils.swift
//  Bankey
//
//  Created by João Pedro on 26/03/23.
//

import UIKit

extension Decimal {
  var doubleValue: Double {
    return NSDecimalNumber(decimal: self).doubleValue;
  };
};
