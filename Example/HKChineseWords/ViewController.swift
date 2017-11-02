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

    @IBOutlet weak var gifImageView: UIImageView!
    var wordArr = Array<String>()
    var index:Int = 0
    
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
//        testHKChineseWord("早")
        testHKChineseWords("冇點難早前網上傳言今年新春氣溫會跌至個位數")
    }
    
    func testHKChineseWords(_ text:String) {
        for character in text {
            let char:String = String(character)
//            print(char)
            wordArr.append(char)
        }
        
        index = 0
        testHKChineseWord(wordArr[index])
    }
    
    func testHKChineseWord(_ word:String) {
        print(HKChineseWords.sharedInstance.getInfo())
        
        HKChineseWords.sharedInstance.getImages(word) { (images:Array<UIImage>, error:Error?) in
            print("error = \(String(describing: error))")
            if error == nil {
                self.setImages(images)
            } else {
                // call next
                self.didAnimationFinished()
            }
        }
    }
    
    func setImages(_ images:Array<UIImage>) {
        self.gifImageView.animationImages = images
        self.gifImageView.animationDuration = 0.5 * Double(images.count)
        self.gifImageView.animationRepeatCount = 1
        self.gifImageView.startAnimating()
        self.perform(#selector(ViewController.didAnimationFinished), with: nil, afterDelay: self.gifImageView.animationDuration)
    }
    
    @objc func didAnimationFinished() {
        print("didAnimationFinished")
        self.gifImageView.stopAnimating()
        
        if index < wordArr.count - 1 {
            index += 1
            testHKChineseWord(wordArr[index])
        } else {
            print("Test Complete!")
        }
    }
}

