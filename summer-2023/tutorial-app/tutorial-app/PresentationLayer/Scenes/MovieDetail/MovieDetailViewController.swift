//
//  MovieDetailViewController.swift
//  tutorial-app
//
//  Created by Yapı Kredi Teknoloji A.Ş. on 25.08.2023.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    let ImagePath: String = "https://image.tmdb.org/t/p/w500"
    let iconView: UIImageView = UIImageView()
    let backgroundImageView: UIImageView = UIImageView()
    let label: UILabel = UILabel()
    let sublabel: UILabel = UILabel()
        
    var indexPathRow: Int?
    var navigationTitle: String?
    var posterPath: String?
    var backdropPath: String?
    var originalTitle: String?
    var releaseDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        debugPrint(indexPathRow ?? 0)
        
        prepareUI()
    }
    private func prepareUI() {
        title = navigationTitle ?? ""
        view.backgroundColor = .black
        
        view.addSubview(backgroundImageView)
                backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                    backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
                    backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3) 
                ])
        backgroundImageView.alpha = 0.5
        if let backdropPath = backdropPath {
                   let backdropURL = URL(string: ImagePath + backdropPath)
                   backgroundImageView.kf.setImage(with: backdropURL)
               }
        
        view.addSubview(iconView)
                iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                   iconView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -30),
                   iconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                   iconView.widthAnchor.constraint(equalToConstant: 120),
                   iconView.heightAnchor.constraint(equalToConstant: 200)
               ])
                
                iconView.layer.cornerRadius = 5
                iconView.clipsToBounds = true
                iconView.layer.masksToBounds = true
                
        if let posterPath = posterPath {
                    let imageURL = URL(string: ImagePath + posterPath)
                    iconView.kf.setImage(with: imageURL)
                }
        
        view.addSubview(label)
                label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                    label.topAnchor.constraint(equalTo: iconView.topAnchor,constant: 40),
                    label.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 20),
                    label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                ])
                label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
                label.textColor = .white
                label.numberOfLines = 0 // Allow multiple lines
                label.lineBreakMode = .byWordWrapping // Wrap by word
                
        if let originalTitle = originalTitle{
            label.text = originalTitle
        }
        
                
    }

}
