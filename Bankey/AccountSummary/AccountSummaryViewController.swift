//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by João Pedro on 26/03/23.
//

import UIKit

class AccountSummaryViewController: UIViewController {
  let tableView = UITableView();
  
  let games = ["Pacman", "Space Invaders", "Space Patrol"];
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    setup();
  };
};

extension AccountSummaryViewController {
  func setup() {
    setupTableView();
    setupTableHeaderView();
  };
  
  func setupTableView() {
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.translatesAutoresizingMaskIntoConstraints = false;
    
    view.addSubview(tableView);
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ]);
  };
  
  private func setupTableHeaderView() {
    let header = AccountSummaryHeaderView(frame: .zero);
    var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize);
    
    size.width = UIScreen.main.bounds.width;
    header.frame.size = size;
    
    tableView.tableHeaderView = header;
  };
};

extension AccountSummaryViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell();
    cell.textLabel?.text = games[indexPath.row];
    
    return cell;
  };
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count;
  };
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    return print("Clicou");
  };
};