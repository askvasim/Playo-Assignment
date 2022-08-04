//
//  NetworkHandler.swift
//  Assignment
//
//  Created by Vasim Khan on 8/4/22.
//

import Foundation

class NetworkHandler {
    
    func getNews(onCompliteion: @escaping ([Articles]) -> ()) {
        let newsAPIPath = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=344d4c9f20ad4e4b8c93bc52e4f65eaf"
        
        if let newsAPIURL = URL(string: newsAPIPath) {
            let request = URLRequest(url: newsAPIURL)
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    do {
                        let decodedData = try JSONDecoder().decode(ArticleData.self, from: safeData)
                        let news = decodedData.articles
                        onCompliteion(news)
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
}
