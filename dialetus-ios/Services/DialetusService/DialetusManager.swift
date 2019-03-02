//
//  DialetusManager.swift
//  dialetus-ios
//
//  Created by Felipe Antonio Cardoso on 02/03/19.
//  Copyright © 2019 Pamela Ianovalli. All rights reserved.
//

import Foundation

class DialetusManager {
    
   static let shared = DialetusManager()
    
    private let session = URLSession(configuration: .default)
    private var sessionTask : URLSessionTask?
    
    private let baseURL = URL(string: "https://dialetus-service.now.sh")!
    
    func regions(completion: @escaping ([Region]?, Error?) -> Void) {
        
        sessionTask?.cancel()
        
        let url = baseURL.appendingPathComponent("regions")
        
        sessionTask = session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let regions = try! JSONDecoder().decode([Region].self, from: data)
            completion(regions, nil)
            
            
        }
        
        sessionTask?.resume()
        
    }
    
    func dialects(from region: String, completion: @escaping ([Dialect]?, Error?) -> Void){
        
        sessionTask?.cancel()
        
        let url = baseURL
            .appendingPathComponent("regions")
            .appendingPathComponent(region)
            .appendingPathComponent("dialects")
        
        
        sessionTask = session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let dialect = try! JSONDecoder().decode([Dialect].self, from: data)
            completion(dialect, nil)
            
            
        }
        
        sessionTask?.resume()
    }
    
}

