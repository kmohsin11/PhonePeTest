//
//  MovieListTableViewCell.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import UIKit
import Kingfisher

protocol MovieListTableViewCellDelegate: AnyObject {
  func didTapAddToPlaylist(at index: Int)
}

class MovieListTableViewCell: UITableViewCell, ReusableView {
  
  @IBOutlet var movieImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var subtitleLabel: UILabel!
  @IBOutlet var playlistLabel: UILabel!
  
  var index: Int!
  weak var delegate: MovieListTableViewCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    movieImageView.image = nil
    movieImageView.kf.cancelDownloadTask()
    titleLabel.text = nil
    subtitleLabel.text = nil
    playlistLabel.text = nil
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
  
  @IBAction func addButtonTapped(_ sender: Any) {
    delegate?.didTapAddToPlaylist(at: index)
  }
  
}
