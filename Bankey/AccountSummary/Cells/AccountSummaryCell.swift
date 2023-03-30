//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by João Pedro on 26/03/23.
//

import UIKit

enum AccountType: String, Codable {
  case Banking
  case CreditCard
  case Investment
};

class AccountSummaryCell: UITableViewCell {
  static let reuseID = "AccountSummaryCell";
  static let rowHeight: CGFloat = 110;
  
  struct ViewModel {
    let accountType: AccountType;
    let accountName: String;
    let balance: Decimal;
    
    var balanceAsAttributedString: NSAttributedString {
      return CurrencyFormatter().makeAttributedCurrency(balance);
    };
  };
  
  let viewModel: ViewModel? = nil
  let typeLabel = UILabel();
  let underlineView = UIView();
  let nameLabel = UILabel();
  let balanceStackView = UIStackView();
  let balanceLabel = UILabel();
  let balanceAmountLabel = UILabel();
  let chevronImageView = UIImageView();
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier);
    
    setup();
    layout();
  };
    
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
};

extension AccountSummaryCell {
  private func setup() {
    typeLabel.translatesAutoresizingMaskIntoConstraints = false;
    typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1);
    typeLabel.adjustsFontForContentSizeCategory = true;
    typeLabel.text = "Account Type";
    
    underlineView.translatesAutoresizingMaskIntoConstraints = false;
    underlineView.backgroundColor = appColor;
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false;
    nameLabel.font = UIFont.preferredFont(forTextStyle: .body);
    nameLabel.adjustsFontSizeToFitWidth = true;
    nameLabel.text = "Account Name";
    
    balanceStackView.translatesAutoresizingMaskIntoConstraints = false;
    balanceStackView.axis = .vertical;
    balanceStackView.spacing = 0;
    
    balanceLabel.translatesAutoresizingMaskIntoConstraints = false;
    balanceLabel.font = UIFont.preferredFont(forTextStyle: .body);
    balanceLabel.textAlignment = .right;
    balanceLabel.adjustsFontSizeToFitWidth = true;
    balanceLabel.text = "Some Balance";
    
    balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false;
    balanceAmountLabel.textAlignment = .right;
    balanceAmountLabel.adjustsFontSizeToFitWidth = true;
    balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "XXX,XXX", cents: "XX")
    
    balanceStackView.addArrangedSubview(balanceLabel);
    balanceStackView.addArrangedSubview(balanceAmountLabel);
    
    chevronImageView.translatesAutoresizingMaskIntoConstraints = false;
    chevronImageView.image = UIImage(systemName: "chevron.right")?.withTintColor(appColor, renderingMode: .alwaysOriginal)
    
    contentView.addSubview(typeLabel);
    contentView.addSubview(underlineView);
    contentView.addSubview(nameLabel);
    contentView.addSubview(balanceStackView);
    contentView.addSubview(chevronImageView)
  };
    
  private func layout() {
    // TypeLabel
    NSLayoutConstraint.activate([
      typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
      typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
    ]);
    
    // UnderlineView
    NSLayoutConstraint.activate([
      underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
      underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
      underlineView.widthAnchor.constraint(equalToConstant: 60),
      underlineView.heightAnchor.constraint(equalToConstant: 4)
    ]);
    
    // NameLabel
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
      nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
    ]);
    
    // Balance StackView
    NSLayoutConstraint.activate([
      balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 0),
      balanceStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 4),
      trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4)
    ]);
    
    // Chevron Image
    NSLayoutConstraint.activate([
      chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1.5),
      trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1),
    ]);
  };
};

extension AccountSummaryCell {
  private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
    let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8];
    let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)];
    let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8];
      
    let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes);
    let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes);
    let centString = NSAttributedString(string: cents, attributes: centAttributes);
      
    rootString.append(dollarString);
    rootString.append(centString);
      
    return rootString;
  };
  
  func configure(with vm: ViewModel) {
    typeLabel.text = vm.accountType.rawValue;
    nameLabel.text = vm.accountName;
    balanceAmountLabel.attributedText = vm.balanceAsAttributedString;
    
    switch vm.accountType {
    case .Banking:
      underlineView.backgroundColor = appColor;
      balanceLabel.text = "Current Balance";
    case .CreditCard:
      underlineView.backgroundColor = .systemOrange;
      balanceLabel.text = "Current Balance";
    case .Investment:
      underlineView.backgroundColor = .systemPurple;
      balanceLabel.text = "Value";
    };
  };
};
