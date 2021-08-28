//
//  NetworkRequestWorker.swift
//  BitbucketHelper
//
//  Created by Chin Wee on 28/8/21.
//

import Foundation

final class NetworkRequestWorker {
    static let shared = NetworkRequestWorker()

    private init() {}

    func get<T: Codable>(
        type: T.Type,
        url: URL,
        successHandler: @escaping (T) -> Void,
        failureHandler: @escaping (Error?) -> Void
    ) {
        var request = URLRequest(url: url)
        request.allowsCellularAccess = true
        request.httpMethod = "GET"
        let session = URLSession.shared.dataTask(with: request) { (data, resp, err) in
            DispatchQueue.main.async {
                guard
                    let data = data, err == nil,
                    let resp = resp as? HTTPURLResponse, resp.statusCode == 200
                else {
                    failureHandler(err)
                    return
                }
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    successHandler(json)
                } catch {
                    failureHandler(error)
                }
            }
        }
        session.resume()
    }
}
