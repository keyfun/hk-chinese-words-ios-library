import Foundation

public class HKChineseWords {
    
    private let POST_URL:String = "http://www.edbchinese.hk/lexlist_ch/result.jsp"
    private let PATTERN:String = "swf?cidx="
    private let GIF_URL:String = "http://www.edbchinese.hk/EmbziciwebRes/stkdemo/%@/%i.gif"
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
    
    public func search(_ text:String, onComplete: @escaping (String) -> Void) {
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
                if let id:Int = self.getWordId(responseString!) {
                    print("word id = \(id)")
                    let url:String = self.getImageUrl(id)
                    print("gif url = \(url)")
                    onComplete(url)
                } else {
                    print("Invalid id")
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
            print("find id = \(id)")
            
            if let idInt:Int? = Int(id) {
                return idInt!
            }
        }
        return -1
    }
    
    private func getImageUrl(_ id:Int) -> String {
        let lower:Int = Int(floor(Double(id / 1000)))
        let upper:Int = (lower + 1) * 1000
        let subPath:String = String(lower * 1000 + 1) + "-" + String(upper)
        let url:String = String(format: GIF_URL, subPath, id)
        return url
    }
}
