//
//  HomeViewController.swift
//  PhotoLog
//
//  Created by 박다혜 on 2023/08/31.
//

import UIKit

// AnyObject: 클래스에서만 프로토콜을 정의할 수 있도록 제약
protocol HomeViewProtocol: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}

class HomeViewController: BaseViewController {

    var list: Photo = Photo(total: 0, total_pages: 0, results: [])
    let mainView = HomeView()

    override func loadView() {
        mainView.delegate = self    // -> 추가하니 deinit이 호출이 안됨
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self

        APIService.shared.request(query: "sky") { [weak self] photo in

            guard let photo = photo else {
                print("alert error")
                return
            }

            self?.list = photo
            self?.mainView.collectionView.reloadData()
        }
    }

    deinit {
        print(self, #function)
    }

    override func configureView() {
        super.configureView()
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.results.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell()}
        cell.imageView.backgroundColor = .systemCyan

        let thumb = list.results[indexPath.item].urls.thumb
        let url = URL(string: thumb)   //링크를 기반으로 이미지를 보여준다? -> 네트워크 통신

        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url!)  //동기 코드

            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        //delegate?.didSelectItemAt(indexPath: indexPath)
    }

}

extension HomeViewController: HomeViewProtocol {

    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        navigationController?.popViewController(animated: true)
    }

}
