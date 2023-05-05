//
//  ViewController.swift
//  JsonDataExample
//
//  Created by Talor Levy on 2/8/23.
//

import UIKit

class ViewController: UIViewController {
    
// MARK: @IBOutlet
    
    @IBOutlet weak var thumbnailCollectionView: UICollectionView!
    
    var viewModel: ThumbnailViewModel?
    var thumbnailArray: [ThumbnailModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ThumbnailViewModel()
        viewModel?.fetchUsersData {
            DispatchQueue.main.async {
                self.thumbnailArray = self.viewModel?.thumbnailArray ?? []
                self.thumbnailCollectionView.reloadData()
            }
        }
    }
}


// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        thumbnailArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thumbnailCell", for: indexPath) as? ThumbnailCollectionViewCell else { return UICollectionViewCell() }
        let thumbnail = thumbnailArray[indexPath.row]
        cell.thumbnailImageView.load(urlString: thumbnail.thumbnailUrl ?? "")
        return cell
    }
}


// MARK: UICollectionViewCell

class ThumbnailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
}


// MARK: UIImageView

extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


