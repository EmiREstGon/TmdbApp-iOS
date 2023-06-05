//
//  ApiService.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 6/6/23.
//

import Foundation
import Alamofire

final class ApiService {
    static let api_key = "bdbf82c3d85dbdf0767b157127b64ec5"
    static let base_url = "https://api.themoviedb.org/3/"
    
    static func get<T: Codable> (endPoint: String, parameters: [String: Any] = [:], callBack: @escaping (T) -> Void) {
        var params = parameters
        params["api_key"] = api_key
        let path = base_url + endPoint
        
        AF.request(path, method: .get, parameters: params).responseDecodable(of: T.self, queue: .main) { result in
//            print("path: " + path)
            if let error = result.error {
                // TODO: remove print
                print(error.localizedDescription)
                print(result)
                return
            }
            
            if let value = result.value {
                callBack(value)
            } else {
                // TODO: remove print
                print("No value on get request to api")
            }
        }
    }
    
    static func post<T: Codable, Body: Encodable> (endPoint: String, body: Body?, callBack: @escaping (T) -> Void, errorCallback: ((ErrorResponse?) -> Void)? = nil) {
        let headers: HTTPHeaders = [
            "Content-type": "application/json"
        ]
        AF.request("\(base_url)\(endPoint)?api_key=\(api_key)", method: .post, parameters: body, encoder: JSONParameterEncoder.default, headers: headers).validate().responseDecodable(of: T.self, queue: .main) { result in
            if let error = result.error {
                // TODO: remove print
                print(error.localizedDescription)
                
                if let data = result.data, let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    errorCallback?(errorResponse)
                    
                    return
                }
            }
            
            if let value = result.value {
                callBack(value)
            } else {
                // TODO: remove print
                print("No value on get request to api")
            }
        }
    }
    
    static func delete<T: Codable, Body: Encodable> (endPoint: String, body: Body?, callBack: @escaping (T) -> Void) {
        let headers: HTTPHeaders = [
            "Content-type": "application/json"
        ]
        AF.request("\(base_url)\(endPoint)?api_key=\(api_key)", method: .delete, parameters: body, encoder: JSONParameterEncoder.default, headers: headers).validate().responseDecodable(of: T.self, queue: .main) { result in
            if let error = result.error {
                // TODO: remove print
                print(error.localizedDescription)
                
                return
            }
            
            if let value = result.value {
                callBack(value)
            } else {
                // TODO: remove print
                print("No value on get request to api")
            }
        }
    }
}
