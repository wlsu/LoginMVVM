//
//  ApiService.swift
//  SCMPTest
//
//  Created by Vincent Su on 25/4/2021.
//

import Foundation

enum ApiService {
    
    private static let loginApiString = "https://reqres.in/api/login?delay=5"
    
    static func loginApiRequest() {
        guard let url = URL(string: loginApiString) else {
            return
        }
        makeRequest(url: url)
    }
    
    
    
    private static func makeRequest(url: URL) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
}
