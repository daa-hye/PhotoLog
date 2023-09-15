//
//  APIService.swift
//  PhotoLog
//
//  Created by 박다혜 on 2023/08/30.
//

import Foundation

class APIService {

    private init() { }

    static let shared = APIService()    // 인스턴스 생성 방지

    func request(query: String, completionHandler: @escaping (Photo?) -> Void) {

        guard let url = URL(string: "https://api.unsplash.com/search/photos?page=1&query=\(query)&client_id=\(APIKey.photo)") else { return }
        let request = URLRequest(url: url, timeoutInterval: 10)
        
        URLSession.shared.dataTask(with: request) { data, response, error in

            DispatchQueue.main.async {
                if let error {
                    completionHandler(nil)
                    return
                }

                guard let response = response as? HTTPURLResponse,
                      (200...500).contains(response.statusCode) else {
                    completionHandler(nil)
                    //print(error) // Alert또는 Do Try Catch 등
                    return
                }

                guard let data = data else {
                    completionHandler(nil)
                    return
                }

                do {
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    completionHandler(result)
                    //print(result)
                } catch {
                    completionHandler(nil)
                }
            }
        }.resume()
    }

}

struct Photo: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResults]
}

struct PhotoResults: Codable {
    let id: String
    let urls: PhotoUrl
}

struct PhotoUrl: Codable {
    let full: String
    let thumb: String
}
