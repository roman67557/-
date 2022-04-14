//
//  ViewAfterShootingViewController.swift
//  ??
//
//  Created by Роман on 30.03.2022.
//

import UIKit

class ViewAfterShootingViewController: UIViewController {

    var imageView = UIImageView()
    var presenter: ViewAfterShootingPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        imageView.frame = self.view.bounds
        
        setup()
    }
   
    func setup() {
        addSubViews()
        setupImageView()
    }
    
    private func addSubViews() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupImageView() {
        imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFill
    }
    
    func addConstraints() {
        
    }

}

extension ViewAfterShootingViewController: ViewAfterShootingProtocol {
    
}
