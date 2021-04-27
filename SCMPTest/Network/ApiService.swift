//
//  ApiService.swift
//  SCMPTest
//
//  Created by Vincent Su on 25/4/2021.
//

import Foundation

enum SCMPApiError: Error {
    case parseJsonFailed
    case unexpected(code: Int)
}

extension SCMPApiError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .parseJsonFailed:
            return "parse json failed"
        case .unexpected(code: _):
            return "An unexpected error occurred."
        }
    }
}

enum ApiService {
    
    
    
    
    
    enum RequestType: String {
        case POST
        case GET
        case PUT
        case DELETE
    }
    
    private static let loginApiString = "https://reqres.in/api/login?delay=5"
    
    static func loginApiRequest(email: String, password: String, completion:@escaping (LoginStatus?) -> Void   ) {
        guard let url = URL(string: loginApiString) else {
            completion(nil)
            return
        }

        makeRequestReturnDict(url: url, method: .POST, parameters: ["email" : email, "password": password]) { (dict, error) in
            guard let theDict = dict else {
                completion(nil)
                return
            }
            
            if let token = theDict["token"] as? String {
                completion(LoginStatus.success(token: token))
                return
            }
            
            if let errorMessage = theDict["error"] as? String  {
                completion(LoginStatus.fail(message: errorMessage))
                return
            }
            
            completion(nil)
        }
    }
    
    static func makeRequestReturnDict(url: URL, method:RequestType, parameters: [String:Any]?, completionHandler: @escaping  ([String:Any]?, Error?) -> Void) {
        makeRequest(url: url, method: method, parameters: parameters) { (object, error) in
            guard let theObject = object, let dict = theObject as? [String: Any] else {
                completionHandler(nil, error)
                return
            }
            completionHandler(dict, nil)
        }
    }
    
    

    private static func makeRequest(url: URL, method:RequestType, parameters: [String:Any]?, completionHandler: @escaping  (Any?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if method == .POST {
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            // compose http body
            if let theParameters = parameters {
                let jsonData = try? JSONSerialization.data(withJSONObject: theParameters)
                request.httpBody = jsonData
            }
            
        }
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    DispatchQueue.main.async {
                        completionHandler(json, nil)
                    }
                    
                    
                } catch {
                    DispatchQueue.main.async {
                        completionHandler(nil, SCMPApiError.parseJsonFailed)
                    }
                    
                }
            } else if let error = error {
                // no data, but got error
                DispatchQueue.main.async {
                    completionHandler(nil,error)
                }
                
            } else {
                // no data, no error
                DispatchQueue.main.async {
                    completionHandler(nil, SCMPApiError.unexpected(code: -1))
                }
                
                
            }
        }


        task.resume()
    }
}
