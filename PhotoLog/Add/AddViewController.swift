//
//  AddViewController.swift
//  PhotoLog
//
//  Created by 박다혜 on 2023/08/28.
//

import UIKit

class AddViewController: BaseViewController {

    let mainView = Addview()

    override func loadView() {  // viewDidLoad 보다 먼저 호출됨, super 메서드 호출X
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil)
    }

    @objc func selectImageNotificationObserver(notificatoin: NSNotification) {
        print("selectImageNotificationObserver")
        print(notificatoin.userInfo?["name"])
        print(notificatoin.userInfo?["sample"])

        if let name = notificatoin.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
        
    }

    @objc func searchButtonClicked() {

        let word = ["Apple", "Banana", "Cookie", "Cake", "Sky"]

        NotificationCenter.default.post(name: NSNotification.Name("RecommandKeyword"), object: nil, userInfo: ["word" : word.randomElement()!])
        
        present(SearchViewController(), animated: true)
    }

    override func configureView() {
        super.configureView()
        print("Add configureView")
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        
    }

    override func setConstraints() {
        super.setConstraints()
        print("Add setConstraints")

    }


}

