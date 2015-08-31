//
//  ViewController.swift
//  KDGradientView
//
//  Created by Michael Michailidis on 28/08/2015.
//  Copyright (c) 2015 karmadust. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var gradientView: GradientView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // borrow from standard color wheel https://en.wikipedia.org/wiki/Color_wheel
        
        gradientView.colors = [
            UIColor.blueColor(),
            // UIColor.cyanColor(),
            UIColor.greenColor(),
            // UIColor.yellowColor(),
            UIColor.redColor(),
            // UIColor.magentaColor()
        ];
    }
    
    @IBAction func next(sender: UIButton) {
        
        gradientView.animateToNextGradient()
        
    }



}

