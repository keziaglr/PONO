//
//  ViewController.swift
//  TestTracing
//
//  Created by Kezia Gloria on 03/10/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        
        let subview = TracingLetter(frame: self.view.bounds)
        view.addSubview(subview)
        subview.center = view.center
    }


}

