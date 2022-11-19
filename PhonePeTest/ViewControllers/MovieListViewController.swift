//
//  ViewController.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: UIViewController {

  @IBOutlet var movieListTableView: UITableView!
  
  let viewModel = MovieListViewModel()
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindObservables()
    viewModel.fetchMovies()
  }
  
  private func setupUI() {
    movieListTableView.delegate = self
    movieListTableView.dataSource = self
    movieListTableView.register(UINib(nibName: MovieListTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: MovieListTableViewCell.reuseIdentifier)
  }
  
  private func bindObservables() {
    viewModel.movieData
      .observe(on: MainScheduler.instance)
      .bind { [weak self] data in
        guard let self = self else { return }
        if let _ = data {
          self.movieListTableView.reloadData()
        } else {
          
        }
      }.disposed(by: disposeBag)
  }

}

// MARK: Tableview methods
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 250
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.movieData.value?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.reuseIdentifier, for: indexPath) as! MovieListTableViewCell
    if let data = viewModel.movieData.value, data.indices.contains(indexPath.row) {
      let movieData = data[indexPath.row]
      let cellData = MovieListCellDataModel(movieData: movieData, playlistData: ["P1", "P2"])
      cell.setupView(cellData)
    }
    return cell
  }
}

