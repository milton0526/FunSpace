//
//  NetworkManager.swift
//  FindBus
//
//  Created by Milton Liu on 2022/9/22.
//

import Foundation
import SwiftUI

class NetworkManager {
    static let shared = NetworkManager()

    func fetch<T: Codable>(city: String, url: URL, completionHandler: @escaping (_ data: [T]?) -> Void) {
        let id = "milton562349-1d15aca0-d1bf-4d0d"
        let secret = "6b42cbc6-1341-4bb6-97fc-c06c92d8a9d6"

        getAuthorization(clientID: id, clientSecret: secret) { token in
            guard let accessToken = token else { return }

            var request = URLRequest(url: url)
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "authorization")

            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                guard
                    let data = data,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return
                }

                let decoder = JSONDecoder()

                do {
                    let decodedData = try decoder.decode([T].self, from: data)
                    completionHandler(decodedData)
                } catch  {
                    print("Decode error: \(error.localizedDescription)")
                }
            }

            dataTask.resume()
        }
    }

    func fetchImage(url: URL, completionHandler: @escaping (_ image: UIImage?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                completionHandler(UIImage(data: data))
            }
        }
        dataTask.resume()
    }

    func getAuthorization(clientID: String, clientSecret: String, completionHandler: @escaping (_ token: String?) -> Void) {

        struct AccessToken: Codable {
            var access_token: String
        }

        let authUrlString = "https://tdx.transportdata.tw/auth/realms/TDXConnect/protocol/openid-connect/token"
        let type = "client_credentials"

        guard let authURL = URL(string: authUrlString) else { return }

        var request = URLRequest(url: authURL)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")

        var requestComponents = URLComponents()
        requestComponents.queryItems = [
            URLQueryItem(name: "grant_type", value: type),
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "client_secret", value: clientSecret)
        ]
        request.httpBody = requestComponents.query?.data(using: .utf8)

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }

            let decoder = JSONDecoder()
            let token = try? decoder.decode(AccessToken.self, from: data)

            completionHandler(token?.access_token)
        }

        dataTask.resume()
    }
}
