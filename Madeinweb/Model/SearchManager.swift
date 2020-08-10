//
//  SearchManager.swift
//  Madeinweb
//
//  Created by Caio  Marastoni on 01/08/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

protocol SearchManagerDelegate {
    func didUpdateSearch(_ searchManager: SearchManager, searchModel: SearchModel)
    func didFailWithError(error: Error)
}

struct SearchManager {
    let searchURL = "https://www.googleapis.com/youtube/v3/search?part=id,snippet&key=AIzaSyBRRj8267SPNGQtL9QfUixeVkLKdBIT0ao"
    
    var delegate: SearchManagerDelegate?
    
    func fetchSearchRequest(searchParameter: String) {
        let urlString = "\(searchURL)&q=\(searchParameter)"
        performRequest(with: urlString)
        print(urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let search = self.parseJSON(videoData: safeData) {
                        self.delegate?.didUpdateSearch(self, searchModel: search)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(videoData: Data) -> SearchModel? {
        let decoder = JSONDecoder()
        var searchResult: SearchModel? = nil
        
        do {
            let decodedData = try decoder.decode(SearchData.self, from: videoData)
            decodedData.items.forEach { (Items) in
                let title = Items.snippet.title
                let description = Items.snippet.description
                let thumbnailMedium = Items.snippet.thumbnails.medium.url
                let thumbnailHigh = Items.snippet.thumbnails.high.url
                
                searchResult = SearchModel(titleModel: title, descriptionModel: description, thumbnailMediumModel: thumbnailMedium, thumbnailHighModel: thumbnailHigh)
                
                
                print(searchResult!.titleModel)
                
            }
            return searchResult
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
