//
//  ViewController.swift
//  HKChineseWords
//
//  Created by Key Hui on 01/20/2017.
//  Copyright (c) 2017 Key Hui. All rights reserved.
//

import UIKit
import HKChineseWords

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        testConnection()
    }
    
    func testConnection() {
        let lib = HKChineseWords()
        print(lib.info())
    }

}

