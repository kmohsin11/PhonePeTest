//
//  ViewController.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import UIKit

class MovieListViewController: UIViewController {

  let viewModel = MovieListViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchMovies()
  }

}

