//
//  WavingView.swift
//  WavingView
//
//  Created by Mostafa on 9/14/19.
//  Copyright © 2019 Mostafa Mazrouh. All rights reserved.
//

import Foundation


extension UIView {
    
    func startWaving(
        leadingGradientColor: UIColor = UIColor.white,
        trailingGradientColor: UIColor = UIColor.black,
        cornerRadius: CGFloat = 0,
        animating: Bool = true
        ) {
        
        let wavingView = UIView(frame: self.bounds)
        wavingView.tag = 777
        wavingView.backgroundColor = UIColor.white
        
        self.addSubview(wavingView)
        self.bringSubviewToFront(wavingView)
        wavingView.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding constraints
        NSLayoutConstraint(item: wavingView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: wavingView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: wavingView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: wavingView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        wavingView.setNeedsLayout()
        
        let colors = [leadingGradientColor, trailingGradientColor]
        
        wavingView.applyGradient(colors: colors, cornerRadius: cornerRadius)
        
        if animating {
            startShimmeringEffect()
        }
        
        return
    }
    
    func endLoadingEffect() {
        var wavingView: UIView?
        for subView in self.subviews {
            if subView.tag == 777 {
                wavingView = subView
                break
            }
        }
        wavingView?.removeFromSuperview()
        self.stopShimmeringEffect()
    }
    
    func applyGradient(colors: [UIColor], cornerRadius: CGFloat? = 0, locations: [NSNumber]? = [0, 1]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = locations
        gradientLayer.frame = self.layer.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        gradientLayer.cornerRadius = cornerRadius ?? 0
        self.layer.cornerRadius = cornerRadius ?? 0
    }
    
    func startShimmeringEffect() {
        let light = UIColor.white.cgColor
        let alpha = UIColor(red: 206/255, green: 10/255, blue: 10/255, alpha: 0.7).cgColor
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3 * self.bounds.size.width, height: self.bounds.size.height)
        gradient.colors = [light, alpha, light]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0,y: 0.525)
        gradient.locations = [0.35, 0.50, 0.65]
        self.layer.mask = gradient
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9,1.0]
        animation.duration = 1.5
        animation.repeatCount = HUGE
        gradient.add(animation, forKey: "shimmer")
    }
    
    func stopShimmeringEffect() {
        self.layer.mask = nil
    }
    

}


















