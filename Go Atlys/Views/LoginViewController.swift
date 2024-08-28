//
//  LoginViewController.swift
//  Go Atlys
//
//  Created by Vaishnav on 27/08/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var carouselView: CarouselView!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImages()
    }
    
    // MARK: - Self made
    
    private func loadImages() {
        let images = [
            UIImage(named: "sample4") ?? UIImage(),
            UIImage(named: "sample5") ?? UIImage(),
            UIImage(named: "sample6") ?? UIImage(),
            UIImage(named: "sample7") ?? UIImage(),
            UIImage(named: "sample8") ?? UIImage(),
            UIImage(named: "sample9") ?? UIImage()
        ]
        
        carouselView.configure(with: images)
    }
    
}
