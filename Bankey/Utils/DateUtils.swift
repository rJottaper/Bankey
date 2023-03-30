//
//  DateUtils.swift
//  Bankey
//
//  Created by João Pedro on 29/03/23.
//

import UIKit

extension Date {
  static var bankeyDateFormatter: DateFormatter {
    let formatter = DateFormatter();
    formatter.timeZone = TimeZone(abbreviation: "MDT");
    return formatter;
  };
    
  var monthDayYearString: String {
    let dateFormatter = Date.bankeyDateFormatter;
    dateFormatter.dateFormat = "MMM d, yyyy";
    return dateFormatter.string(from: self);
  };
};
