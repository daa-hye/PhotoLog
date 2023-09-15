//
//  HomeCollectionViewController.swift
//  PhotoLog
//
//  Created by 박다혜 on 2023/09/15.
//

import UIKit
import SnapKit
import Kingfisher

class HomeCollectionViewController: BaseViewController {

    //var list: Photo = Photo(total: 0, total_pages: 0, results: [])
    var list: [PhotoResults] = []
    let mainView = HomeView()
    let pic = UIImageView()

    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, PhotoResults>!

    override func loadView() {
        mainView.delegate = self
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self

        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            guard let url = URL(string: itemIdentifier.urls.thumb) else { return }
            let resource = KF.ImageResource(downloadURL: url)

            KingfisherManager.shared.retrieveImage(with: resource) { result in

                switch result{
                case .success(let value):
                    content.image = value.image
                    cell.contentConfiguration = content
                case .failure(let error):
                    print(error)
                }
            }
        })

        APIService.shared.request(query: "sky") { [weak self] photo in

            guard let photo = photo else {
                print("alert error")
                return
            }

            self?.list = photo.results
            self?.mainView.collectionView.reloadData()
        }

    }

    override func configureView() {
        super.configureView()

    }

}

extension HomeCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = list[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: data)
        return cell
    }

}

extension HomeCollectionViewController: HomeViewProtocol {

    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        navigationController?.popViewController(animated: true)
    }

}
