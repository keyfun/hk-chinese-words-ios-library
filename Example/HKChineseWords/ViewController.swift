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

    @IBOutlet weak var gifImage: UIImageView!
    
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
        
        // start run testing
        testHKChineseWords()
    }
    
    func testHKChineseWords() {
        print(HKChineseWords.sharedInstance.getInfo())
        HKChineseWords.sharedInstance.search("許", onComplete: {
            url in
            print(url)
            self.setImageUrl(url)
        })
    }
    
    func setImageUrl(_ url:String) {
        
    }

}

