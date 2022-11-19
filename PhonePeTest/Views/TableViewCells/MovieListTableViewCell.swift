//
//  MovieListTableViewCell.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import UIKit
import Kingfisher

class MovieListTableViewCell: UITableViewCell, ReusableView {
  
  @IBOutlet var movieImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var subtitleLabel: UILabel!
  @IBOutlet var playlistLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  func setupView(_ data: MovieListCellDataModel) {
    movieImageView.kf.setImageUsingBaseURL(data.movieData.bgPath)
    titleLabel.text = data.movieData.title
    subtitleLabel.text = "\(data.movieData.voteAverage ?? 0)"
    var playlistText = data.playlistData.reduce("") {"\($0)\($1), "}
    if playlistText.last == " " {
      playlistText.removeLast()
      playlistText.removeLast()
    }
    playlistLabel.text = playlistText
  }
}
