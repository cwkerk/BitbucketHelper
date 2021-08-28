//
//  ImageLoader.swift
//  BitbucketHelper
//
//  Created by Chin Wee on 28/8/21.
//

import UIKit

extension UIImageView {
    func loadImage(uri: String) {
        guard let url = URL(string: uri) else { return }
        var request = URLRequest(url: url)
        request.allowsCellularAccess = true
        request.httpMethod = "GET"
        let session = URLSession.shared.dataTask(with: request) { (data, resp, err) in
            DispatchQueue.main.async {
                guard
                    let data = data, err == nil,
                    let resp = resp as? HTTPURLResponse, resp.statusCode == 200
                else {
                    return
                }
                self.image = UIImage(data: data)
            }
        }
        session.resume()
    }
}
