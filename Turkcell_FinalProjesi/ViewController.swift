//
//  ViewController.swift
//  Turkcell_FinalProjesi
//
//  Created by Gulsah Altiparmak on 30.01.2021.
//

import UIKit
import Lottie
class ViewController: UIViewController {
   // let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ui = UIOperations()
        ui.splashGradientLayer(view: view)
        ui.splashAnimation(view: view,animationTitle: "shopping-cart")
        timer(time: 3.0)
    }
    
    func timer(time:Double) {
        Timer.scheduledTimer(withTimeInterval: time, repeats: false) { (timer) in
            self.performSegue(withIdentifier: "dashboard", sender: nil)
        }
    }


}


