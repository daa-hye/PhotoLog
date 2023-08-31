//
//  PhotoAPIManager.swift
//  PhotoLog
//
//  Created by 박다혜 on 2023/08/31.
//

import Foundation
import Alamofire

class PhotoAPIManager {

    static let shared = PhotoAPIManager()

    private init() { }

    func request(query: String, completionHandler: @escaping (PhotoResult) -> ()) {
        let url = "https://api.unsplash.com/search/photos?page=1&query=\(query)&client_id=\(APIKey.photo)"

        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: PhotoResult.self, completionHandler: { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            })
    }
}
