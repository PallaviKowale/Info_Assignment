//
//  NetworkUtil.swift
//  Info_Project
//
//  Created by Pallavi Kowale on 16/01/20.
//  Copyright © 2020 Pallavi Kowale. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkOperationDataDelegate : class {
    
    /// Delegate Method to return data received from server
    func dataRecieved(response:AnyObject?)
    
   
    
}


class NetworkUtil {
    
    /// NetworkOperationDataDelegate declaration , used for networking method callback for error or success
    weak var delegate:NetworkOperationDataDelegate?
    
   public func parseData() {
        let session = URLSession.shared
        var webUrl = "https://api.github.com/users/hadley/orgs"
        ////webUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        let url = URL(string: webUrl)!
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                print("json data \(json)")
                
                
                DispatchQueue.main.async {
                self.delegate?.dataRecieved(response: json as AnyObject)
                    
                }
                
                
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
        
    }
    
}
