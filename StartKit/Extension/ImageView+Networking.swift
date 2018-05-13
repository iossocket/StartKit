//
//  ImageView+Networking.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/14.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
  func configureImage(withURL url: URL) {
    kf.setImage(with: url)
  }
}
