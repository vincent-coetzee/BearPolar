//
//  ViewController.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/01.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let layer = MaskedImageLayer()
        self.view.layer.addSublayer(layer)
        layer.frame = CGRect(x:100,y:100,width:200,height:200)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

