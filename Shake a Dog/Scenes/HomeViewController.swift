//
//  HomeViewController.swift
//  Shake a Dog
//
//  Created by Adolpho Piazza on 29/04/21.
//

import UIKit
import SDWebImage
import Lottie

class HomeViewController: UIViewController {

    private let dogImageView: UIImageView = UIImageView()
    private let dogImageBackView: UIImageView = UIImageView()
    private let runningDog = AnimationView(name: "running-dog")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDogImageBackView()
        setupDogImageView()
        fetchDog()
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        fetchDog()
    }

}

//MARK: - API Call
extension HomeViewController {
    
    private func fetchDog() {
        startRunningDog()
        NetworkManager.shared.fetch { imageURL in
            guard let dogURL = URL(string: imageURL) else { return }
            self.dogImageView.sd_setImage(with: dogURL) {_,_,_,_ in
                self.dogImageBackView.image = self.dogImageView.image?.sd_blurredImage(withRadius: 10)
                self.stopRunningDog()
            }
        }
    }
    
}

//MARK: - Animation functions
extension HomeViewController {
    
    private func startRunningDog() {
        view.addSubview(runningDog)
        
        runningDog.contentMode = .scaleAspectFit
        runningDog.frame = view.bounds
        runningDog.loopMode = .loop
        
        runningDog.play()
    }
    
    private func stopRunningDog() {
        runningDog.removeFromSuperview()
        runningDog.stop()
    }
    
}

//MARK: - Layouts
extension HomeViewController {
    
    private func setupDogImageView() {
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dogImageView)
        
        dogImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            dogImageView.topAnchor.constraint(equalTo: view.topAnchor),
            dogImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dogImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dogImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupDogImageBackView() {
        dogImageBackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dogImageBackView)
        
        dogImageBackView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            dogImageBackView.topAnchor.constraint(equalTo: view.topAnchor),
            dogImageBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dogImageBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dogImageBackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
