//
//  ViewController.swift
//  tutorial-app
//
//  Created by Yapı Kredi Teknoloji on 10.08.2023.
//

import UIKit
import Kingfisher

final class ViewController: UIViewController {
    
    let customTableView: UITableView = UITableView()
    let appLogoImageView: UIImageView = UIImageView(image: UIImage(named: "applogo.png"))
    
    var viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Popular Movies"
        
        prepareUI()
        initTableView()
        loadPopularMovies()
        viewModelBindings()
    }
    func loadPopularMovies() {
        viewModel.loadPopularMoview()
    }
    
    private func viewModelBindings() {
        viewModel.reloadTableViewClosure = { [weak self] in
            self?.customTableView.reloadData()
        }
    }
    
    private func prepareUI() {
        
        view.backgroundColor = .black
                
        view.addSubview(appLogoImageView)
        appLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appLogoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            appLogoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            appLogoImageView.widthAnchor.constraint(equalToConstant: 100),
            appLogoImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        customTableView.backgroundColor = .black
        view.addSubview(customTableView)
        customTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customTableView.topAnchor.constraint(equalTo: appLogoImageView.bottomAnchor, constant: 10),
            customTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func initTableView() {
           customTableView.delegate = self
           customTableView.dataSource = self
           customTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "DefaultCell")
       }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath) as? CustomTableViewCell
        
        cell?.viewModel = CustomCellViewModel(title: viewModel.movie(at: indexPath.row)?.title ?? "", subtitle: viewModel.movie(at: indexPath.row)?.releaseDate ?? "", posterPath: viewModel.movie(at: indexPath.row)?.posterPath ?? "",backdropPath: viewModel.movie(at: indexPath.row)?.backdropPath ?? "",isAdult: viewModel.movie(at: indexPath.row)?.adult ?? false,voteAverage: viewModel.movie(at: indexPath.row)?.voteAverage ?? 0.0)
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = MovieDetailViewController()
        nextViewController.indexPathRow = indexPath.row
        nextViewController.navigationTitle = viewModel.movie(at: indexPath.row)?.title ?? ""
        nextViewController.posterPath = viewModel.movie(at: indexPath.row)?.posterPath ?? ""
        nextViewController.backdropPath = viewModel.movie(at: indexPath.row)?.backdropPath ?? ""
        nextViewController.originalTitle = viewModel.movie(at: indexPath.row)?.originalTitle ?? ""
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

}

