//
//  GitHubNewsCell.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/14.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import UIKit

class GitHubEventCell: UITableViewCell {
  @IBOutlet weak var typeIconImageView: UIImageView!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var avatorImageView: UIImageView!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure(with event: Event) {
    let viewModel = GitHubEventCellViewModel(event: event)
    timeLabel.text = viewModel.time
    descriptionLabel.attributedText = viewModel.description
    viewModel.avatorURL.flatMap(avatorImageView.configureImage(withURL:))
  }
}
