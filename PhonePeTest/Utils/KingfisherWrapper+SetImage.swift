//
//  KingfisherWrapper+SetImage.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import Foundation
import Kingfisher

extension KingfisherWrapper where Base: UIImageView {
  func setImageUsingBaseURL(_ imagePath: String?) {
    guard let imagePath = imagePath else { return }
    let baseURL = "https://image.tmdb.org/t/p/w500"
    let url = URL(string: baseURL + imagePath)
    setImage(with: url)
  }
}
