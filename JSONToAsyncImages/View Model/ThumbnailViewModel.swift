//
//  PostViewModel.swift
//  JsonDataExample
//
//  Created by Talor Levy on 2/8/23.
//

import Foundation

class ThumbnailViewModel {
    
    var thumbnailArray: [ThumbnailModel] = []
    
    func fetchUsersData(completion: @escaping() -> Void) {
        NetworkManager.sharedInstance.fetchData(urlString: Constants.urls.link.rawValue) {  [weak self] result in
            switch result {
            case .success(let thumbnails):
                self?.thumbnailArray = thumbnails
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
