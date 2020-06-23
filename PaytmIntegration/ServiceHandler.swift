//
//  ServiceHandler.swift
//  SampleUITest
//
//  Created by Sebastin on 24/10/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

class ServiceHandler: NSObject {
    
    static let sharedServiceHandler = ServiceHandler()
    
    var config: URLSessionConfiguration?
    var session: URLSession?
    
    private override init() {
        config = URLSessionConfiguration.default
        session = URLSession.init(configuration: config ?? URLSessionConfiguration.default)
    }
    
    /** Common service handler
     * input param - url, request param, completion closure
     */
    
    func makeServiceCall(strURL: String?, param: [String: Any]?, completion:@escaping(Data?, URLResponse?, Error?) -> Void) {
        
        guard let strURL = strURL, let url = URL(string: strURL) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
       do {
        request.httpBody = try JSONSerialization.data(withJSONObject: param ?? [:], options: .prettyPrinted)
       } catch let error {
           print(error.localizedDescription)
       }
        
        let task = self.session?.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }
        task?.resume()
    }
}
