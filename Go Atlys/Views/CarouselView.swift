//
//  CarouselView.swift
//  Go Atlys
//
//  Created by Vaishnav on 27/08/24.
//

import UIKit

class CarouselView: UIView {
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private var imageViews: [UIImageView] = []
    
    private var centerImageView: UIImageView? {
        return imageViews.first { $0.frame.contains(self.convert(self.center, to: scrollView)) }
    }
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set the correct width for each imageView
        
        for imageView in imageViews {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        }
        
        if scrollView.contentOffset == .zero, let firstImage = imageViews.first {
            let offsetX = firstImage.frame.origin.x - (scrollView.frame.width - firstImage.frame.width) / 2
            scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
            zoomImageView(firstImage)
        }
        
    }

    private func setupView() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        scrollView.isPagingEnabled = true
        
        // Add constraints to scrollView to fill the CarouselView
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Add constraints to stackView to fill the scrollView horizontally
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        scrollView.delegate = self
    }
    
    // Public method to configure images
    func configure(with images: [UIImage]) {
        
        for imageView in imageViews {
            imageView.removeFromSuperview()
        }
        imageViews.removeAll()
        
        for image in images {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.layer.cornerRadius = 12
            imageView.clipsToBounds = true
            
            stackView.addArrangedSubview(imageView)
            imageViews.append(imageView)
        }
        
        setNeedsLayout()
        layoutIfNeeded()
        
        // Ensure the content offset is set to the first image
        if let firstImage = imageViews.first {
            let offsetX = firstImage.frame.origin.x - (scrollView.frame.width - firstImage.frame.width) / 2
            scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        }
    }
    
    private func zoomImageView(_ imageView: UIImageView) {
        UIView.animate(withDuration: 0.3) {
            self.imageViews.forEach { $0.transform = .identity }
            imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
}

extension CarouselView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let centerImageView = centerImageView {
            zoomImageView(centerImageView)
        }
    }
}
