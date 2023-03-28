//
//  CurrencyFormattedTests.swift
//  BankeyUnitTests
//
//  Created by João Pedro on 27/03/23.
//

import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase {
  var formatter: CurrencyFormatter!
  
  override func setUp() {
    super.setUp();
    
    formatter = CurrencyFormatter();
  };
  
  func testBreakDollarsIntoCents() throws {
    let result = formatter.breakIntoDollarsAndCents(929466.23);
    XCTAssertEqual(result.0, "929,466");
    XCTAssertEqual(result.1, "23");
  };
  
  func testDollarsFormatted() throws {
    let result = formatter.dollarsFormatted(929466);
    XCTAssertEqual(result, "$929,466.00");
  };
  
  func testZeroDollarsFormatted() throws {
    let result = formatter.dollarsFormatted(0.00);
    XCTAssertEqual(result, "$0.00");
  };
};
