//
//  StartAnimationViewController.swift
//  Notes
//
//  Created by Mikhail Chuparnov on 21.12.2022.
//

import UIKit
import Lottie
import SnapKit

class StartAnimationViewController: UIViewController {

    let animationView = LottieAnimationView()
    
    let userDefaults = UserDefaults.standard
    
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupViews()
        setupAnimation()
        setupMainViewController()
    }
    
    private func setupViews() {
        view.addSubview(animationView)
        
        animationView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setupAnimation() {
        animationView.animation = LottieAnimation.named("start")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()
    }
    
    private func setupMainViewController() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.3, repeats: false, block: { _ in
            let vc = UINavigationController(rootViewController: NotesViewController())
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
            self.animationView.layer.opacity = 0
            self.animationView.removeFromSuperview()
        })
    }

}
