//
//  PlaylistViewController.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class PlaylistViewController: UIViewController {

  @IBOutlet var playlistTextField: UITextField!
  @IBOutlet var playlistTableView: UITableView!
  
  let viewModel: PlaylistViewModel
  let disposeBag = DisposeBag()
  
  init(_ viewModel: PlaylistViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchPlaylists()
    bindObservables()
    setupUI()
  }
  
  private func setupUI() {
    playlistTableView.delegate = self
    playlistTableView.dataSource = self
    playlistTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
  }
  
  private func bindObservables() {
    viewModel.playlistData
      .observe(on: MainScheduler.instance)
      .bind { [weak self] data in
        guard let self = self else { return }
        if let _ = data {
          self.playlistTableView.reloadData()
        } else {
          
        }
      }.disposed(by: disposeBag)
  }
  
  @IBAction func playlistButtonTapped(_ sender: Any) {
    viewModel.createNewPlaylist(playlistTextField.text ?? "")
    playlistTextField.text = nil
  }
  
}

// MARK: Tableview methods
extension PlaylistViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.addMovieToPlaylist(indexPath.row)
    dismiss(animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.playlistData.value?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
    if let data = viewModel.playlistData.value, data.indices.contains(indexPath.row) {
      let playlistData = data[indexPath.row]
      cell.textLabel?.text = playlistData.name
    }
    return cell
  }
}

