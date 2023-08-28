//
//  CustomTableViewCell.swift
//  tutorial-app
//
//  Created by Yapı Kredi Teknoloji on 10.08.2023.
//

import UIKit
import Kingfisher

final class CustomTableViewCell: UITableViewCell {
    
    private let iconView: UIImageView = UIImageView()
    private let label: UILabel = UILabel()
    private let sublabel: UILabel = UILabel()
    private var ImagePath: String = "https://image.tmdb.org/t/p/w500"
    private var backgroundImageView: UIImageView = UIImageView()
    private var vote: UILabel = UILabel()
    private var adultView: UIImageView = UIImageView()
    private var starStackView: UIStackView = UIStackView()
    private var overview: UILabel = UILabel()
    
    var viewModel: CustomCellViewModel? {
        didSet {
            guard let data = viewModel else { return }
            configureCell(data: data)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        prepareUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareUI() {
        contentView.backgroundColor = .black
        
        
        contentView.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
           
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 10
        backgroundImageView.layer.borderWidth = 1
        backgroundImageView.layer.borderColor = UIColor.darkGray.cgColor
                
        backgroundImageView.addSubview(iconView)
        backgroundImageView.addSubview(label)
        backgroundImageView.addSubview(sublabel)
        backgroundImageView.addSubview(adultView)
        backgroundImageView.alpha = 0.4
        
        contentView.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
        iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
        iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        iconView.heightAnchor.constraint(equalToConstant: 150),
        iconView.widthAnchor.constraint(equalToConstant: 90)
        ])
                
        iconView.layer.cornerRadius = 5
        iconView.clipsToBounds = true
        iconView.layer.masksToBounds = true

        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 4)
        ])

        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        

        contentView.addSubview(starStackView)
                starStackView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    starStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    starStackView.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 4),
                    starStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18)
                ])
                
                starStackView.axis = .horizontal
                starStackView.spacing = 2
                
                for _ in 1...10 {
                    let starLabel = UILabel()
                    starLabel.text = "☆"
                    starLabel.textColor = .systemOrange
                    starStackView.addArrangedSubview(starLabel)
                }
        
        contentView.addSubview(sublabel)
        sublabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sublabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            sublabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            sublabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            
        ])

        sublabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        sublabel.textColor = .lightGray
        
        contentView.addSubview(adultView)
        adultView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        adultView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 10),
        adultView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -10),
        adultView.heightAnchor.constraint(equalToConstant: 24),
        adultView.widthAnchor.constraint(equalToConstant: 24)
                ])
        adultView.layer.cornerRadius = 12
        adultView.clipsToBounds = true
        adultView.layer.masksToBounds = true
        adultView.image = UIImage(named: "adult.jpg")
        adultView.isHidden = true
        
        contentView.addSubview(overview)
        overview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            overview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            overview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            
        ])
        overview.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        overview.textColor = .white
        overview.isHidden = true
    }
    private func configureCell(data: CustomCellViewModel) {
        label.text = data.title
        sublabel.text = data.subtitle
        iconView.kf.setImage(with: URL(string: ImagePath + data.posterPath))
        backgroundImageView.kf.setImage(with: URL(string: ImagePath + data.backdropPath))
        adultView.isHidden = !data.isAdult
        configureVoteAverage(voteAverage: data.voteAverage)
    }

    func configureVoteAverage(voteAverage: Double) {
            let filledStarCount = Int(voteAverage / 10.0 * 10)
            
            for i in 0..<starStackView.arrangedSubviews.count {
                if i < filledStarCount {
                    (starStackView.arrangedSubviews[i] as? UILabel)?.text = "★"
                } else {
                    (starStackView.arrangedSubviews[i] as? UILabel)?.text = "☆"
                }
            }
        }
}

