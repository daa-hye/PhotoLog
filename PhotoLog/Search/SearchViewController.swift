//
//  SearchViewController.swift
//  PhotoLog
//
//  Created by 박다혜 on 2023/08/28.
//

import UIKit
import Kingfisher

class SearchViewController: BaseViewController {

    let mainView = SearchView()

    weak var delegate: PassImageDelegate?

    var imageList: [URL] = []

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //addObserver보다 post가 먼저 신호를 보내서 작동이 안되는 코드
//        NotificationCenter.default.addObserver(self, selector: #selector(recommandKeywordNotificationObserver), name: NSNotification.Name("RecommandKeyword"), object: nil)

        mainView.searchBar.becomeFirstResponder()
        mainView.searchBar.delegate = self

    }

    @objc func recommandKeywordNotificationObserver(notification: NSNotification) {
        print("recommandKeywordNotificationObserver")
    }

    override func configureView() {
        super.configureView()

        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }

        cell.imageView.kf.setImage(with: imageList[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        delegate?.receiveImage(image: imageList[indexPath.item])
        //NotificationCenter를 통한 값전달
//        NotificationCenter.default.post(name: NSNotification.Name("SelectImage"), object: nil, userInfo: ["name": imageList[indexPath.item], "sample":"고래밥"])

        dismiss(animated: true)
    }

}

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = mainView.searchBar.text else { return }
        PhotoAPIManager.shared.request(query: text) { [weak self] data in
            guard let results = data.results else { return }
            for result in results {
                guard let url = URL(string: result.urls.raw) else { return }
                self?.imageList.append(url)
            }
            self?.mainView.collectionView.reloadData()
        }
        mainView.searchBar.resignFirstResponder()
    }
}
