//
//  ViewController.swift
//  DaangnMarket
//
//  Created by 박지승 on 2020/03/20.
//  Copyright © 2020 Jisng. All rights reserved.
//

import UIKit
import Then
import SnapKit

class HomeFeedViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBackground
  }
  private func doFirstViewAlert() {
    let firstVC = FirstAlertViewController()
    present(firstVC, animated: false)
  }
}
