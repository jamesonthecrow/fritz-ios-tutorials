//
//  ViewController.swift
//  FritzStyleTransferDemo
//
//  Created by Christopher Kelly on 9/12/18.
//  Copyright © 2018 Fritz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var previewView = VideoPreviewView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add preview View as a subview
        view.addSubview(previewView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        previewView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

