//
//  NotificationListContainer.swift
//  DaangnMarket
//
//  Created by cskim on 2020/04/15.
//  Copyright © 2020 Jisng. All rights reserved.
//

import UIKit

class NotificationTableView: UIView {
  // MARK: Interface
  
  func setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
    self.scrollView.setContentOffset(contentOffset, animated: animated)
  }
  
  func setEditing(_ editing: Bool) {
    self.activityNotiTableView
      .visibleCells
      .compactMap { $0 as? ActivityNotificationCell }
      .forEach { $0.setEditMode(editing, for: self.activityNotiTableView) }
    
    self.keywordNotiTableView
      .visibleCells
      .compactMap { $0 as? KeywordNotificationCell }
      .forEach { $0.setEditMode(editing, for: self.activityNotiTableView) }
  }
  
  func dequeueCell(_ type: NotificationType, for indexPath: IndexPath) -> NotificationCell {
    switch type {
    case .activity:
      return self.activityNotiTableView.dequeueReusableCell(withIdentifier: ActivityNotificationCell.identifier, for: indexPath) as? ActivityNotificationCell ?? NotificationCell()
    case .keyword:
      return self.keywordNotiTableView.dequeueReusableCell(withIdentifier: KeywordNotificationCell.identifier, for: indexPath) as? KeywordNotificationCell ?? NotificationCell()
    }
  }
  
  func isActivityNotification(_ tableView: UITableView) -> Bool {
    return tableView.isEqual(self.activityNotiTableView)
  }
  
  func isKeywordNotification(_ tableView: UITableView) -> Bool {
    return tableView.isEqual(self.keywordNotiTableView)
  }
  
  // MARK: Delegation

  weak var scrollViewDelegate: UIScrollViewDelegate? {
    get { return self.scrollView.delegate }
    set { self.scrollView.delegate = newValue }
  }
  
  func setTableViewDelegate(_ delegate: UITableViewDelegate) {
    self.activityNotiTableView.delegate = delegate
    self.keywordNotiTableView.delegate = delegate
  }
  
  func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
    self.activityNotiTableView.dataSource = dataSource
    self.keywordNotiTableView.dataSource = dataSource
  }
  
  enum NotificationType {
    case activity, keyword
  }
  
  func setTableViewDelegate(_ delegate: UITableViewDelegate, for type: NotificationType) {
    switch type {
    case .activity:
      self.activityNotiTableView.delegate = delegate
    case .keyword:
      self.keywordNotiTableView.delegate = delegate
    }
  }
  
  func tableViewDelegate(for type: NotificationType) -> UITableViewDelegate? {
    switch type {
    case .activity:
      return self.activityNotiTableView.delegate
    case .keyword:
      return self.keywordNotiTableView.delegate
    }
  }
  
  func setTableViewDataSource(_ dataSource: UITableViewDataSource, for type: NotificationType) {
    switch type {
    case .activity:
      self.activityNotiTableView.dataSource = dataSource
    case .keyword:
      self.keywordNotiTableView.dataSource = dataSource
    }
  }
  
  func tableViewDataSource(for type: NotificationType) -> UITableViewDataSource? {
    switch type {
    case .activity:
      return self.activityNotiTableView.dataSource
    case .keyword:
      return self.keywordNotiTableView.dataSource
    }
  }
  
  // MARK: Views
  
  private lazy var scrollView = UIScrollView().then {
    $0.isPagingEnabled = true
    $0.showsHorizontalScrollIndicator = false
  }
  private lazy var activityNotiTableView = UITableView().then {
    $0.register(ActivityNotificationCell.self, forCellReuseIdentifier: ActivityNotificationCell.identifier)
    let insetX = $0.separatorInset.left
    $0.separatorInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
  }
  private lazy var keywordNotiTableView = UITableView().then {
    $0.register(KeywordNotificationCell.self, forCellReuseIdentifier: KeywordNotificationCell.identifier)
    let insetX = $0.separatorInset.left
    $0.separatorInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
  }
  
  // MARK: Initialize
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupUI()
  }
  
  private func setupUI() {
    self.setupAttributes()
    self.setupConstraints()
  }
  
  private func setupAttributes() {
    self.scrollView.isPagingEnabled = true
    self.scrollView.showsHorizontalScrollIndicator = false
  }
  
  private func setupConstraints() {
    self.scrollView
      .then { self.addSubview($0) }
      .snp.makeConstraints { $0.edges.equalToSuperview() }
    
    self.activityNotiTableView
      .then { self.scrollView.addSubview($0) }
      .snp.makeConstraints { $0.top.leading.bottom.size.equalToSuperview() }
    
    self.keywordNotiTableView
      .then { self.scrollView.addSubview($0) }
      .snp.makeConstraints {
        $0.top.trailing.bottom.size.equalToSuperview()
        $0.leading.equalTo(self.activityNotiTableView.snp.trailing)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
