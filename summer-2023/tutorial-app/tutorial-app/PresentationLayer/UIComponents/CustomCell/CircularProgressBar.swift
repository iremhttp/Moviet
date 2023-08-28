//
//  CircularProgressBar.swift
//  tutorial-app
//
//  Created by Irem Hatipoğlu on 28.08.2023.
//

import UIKit

class CircularProgressBar: UIView {
    
    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let percentageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let circularPath = UIBezierPath(arcCenter: center, radius: bounds.width / 2 - 10, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.systemOrange.cgColor
        progressLayer.lineWidth = 10
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
        
        percentageLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
                percentageLabel.center = CGPoint(x: bounds.midX, y: bounds.midY)
                percentageLabel.textAlignment = .center
                percentageLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
                percentageLabel.textColor = .white
                addSubview(percentageLabel)
    }
    
    func setProgress(_ progress: Float) {
           progressLayer.strokeEnd = CGFloat(progress)
           percentageLabel.text = "\(Int(progress * 100))%"
       }
}

