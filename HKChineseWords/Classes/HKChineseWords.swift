//
//  HKChineseWords.swift
//  HKChineseWords
//
//  Created by Key Hui on 01/20/2017.
//  Copyright (c) 2017 Key Hui. All rights reserved.
//

import Foundation

public class HKChineseWords {
    
    private let POST_URL:String = "http://www.edbchinese.hk/lexlist_ch/result.jsp"
    private let PATTERN:String = "swf?cidx="
    private let GIF_URL:String = "http://www.edbchinese.hk/EmbziciwebRes/stkdemo/%@/%@.gif"
    // eg: http://www.edbchinese.hk/EmbziciwebRes/stkdemo/3001-4000/3894.gif
    
    // POST Parameters:
    // searchMethod = direct
    // searchCriteria = 字
    // sortBy = storke
    // jpC = Ishk
    // Submit = 搜尋
    
    public static let sharedInstance:HKChineseWords = HKChineseWords()
    
    private init() {
        
    }
    
    public func getInfo() -> String {
        return POST_URL
    }
    
    public func getImages(_ text:String, completion: @escaping (_ images: Array<UIImage>, _ error: Error?) -> Void) {
        self.getUrl(text) { (url:String, error:Error?) in
            if let checkedUrl = URL(string: url) {
                self.downloadImage(url: checkedUrl, completion: completion)
            } else {
                completion([], error)
            }
        }
    }
    
    public func getUrl(_ text:String, completion: @escaping (_ url:String, _ error:Error?) -> Void) {
        var request = URLRequest(url: URL(string: POST_URL)!)
        request.httpMethod = "POST"
        let postString = "searchMethod=direct&sortBy=storke&jpC=Ishk&searchCriteria=" + text
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(responseString)")
            if responseString != nil {
                let id:Int = self.getWordId(responseString!)
                if id != -1 {
                    print("word id = \(id)")
                    let url:String = self.getImageUrl(id)
                    print("gif url = \(url)")
                    completion(url, nil)
                } else {
                    print("Invalid id")
                    completion("", NSError(domain:"keyfun.app.HKChineseWords", code:405, userInfo:nil))
                }
            } else {
                print("Invalid responseString")
            }
        }
        task.resume()
    }
    
    private func getWordId(_ text:String) -> Int {
        if let range = text.range(of: PATTERN) {
            let lo = text.index(range.lowerBound, offsetBy: PATTERN.characters.count)
            let hi = text.index(range.lowerBound, offsetBy: PATTERN.characters.count + 4)
            let subRange = lo ..< hi
            let id:String = text[subRange]
//            print("find id = \(id)")
            
            if let idInt:Int = Int(id) {
                return idInt
            }
        }
        return -1
    }
    
    private func getImageUrl(_ id:Int) -> String {
        let lower:Int = Int(floor(Double(id / 1000)))
        let upper:Int = (lower + 1) * 1000
        
        var idStr:String = String(id)
        var lowerStr:String = ""
        var upperStr:String = ""
        if id < 1000 {
            // append leading zero
            lowerStr = String(format: "%04d", lower + 1)
            idStr = String(format: "%04d", id)
        } else {
            lowerStr = String(lower * 1000 + 1)
        }
        
        if id > 4000 {
            upperStr = "ZC"
        } else {
            upperStr = String(upper)
        }
        
        let subPath:String = lowerStr + "-" + upperStr
        let url:String = String(format: GIF_URL, subPath, idStr)
        return url
    }
    
    private func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    private func downloadImage(url: URL, completion: @escaping (_ images: Array<UIImage>, _ error: Error?) -> Void) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                if let image = UIImage(data: data) {
                    // return image data
                    self.convertImageArr(image, completion: completion)
                } else {
//                    print("Download Failed")
                    completion([], NSError(domain:"keyfun.app.HKChineseWords", code:404, userInfo:nil))
                }
            }
        }
    }
    
    private func convertImageArr(_ rawImage:UIImage, completion: @escaping (_ images: Array<UIImage>, _ error: Error?) -> Void) {
        var imageArr = Array<UIImage>()
        
        let width = Int(rawImage.size.width)
        let height = Int(rawImage.size.height)
        let numOfFrame = Int(width / height)
        
        for i:Int in 0 ..< numOfFrame {
            let x = i * height
            let cropRect = CGRect(x: x, y: 0, width: height, height: height)
            let imageRef = rawImage.cgImage!.cropping(to: cropRect)
            let cropImage = UIImage(cgImage: imageRef!)
            imageArr.append(cropImage)
        }
        
        // return imageArr
        completion(imageArr, nil)
    }
}
