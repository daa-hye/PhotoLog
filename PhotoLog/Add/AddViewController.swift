//
//  AddViewController.swift
//  PhotoLog
//
//  Created by 박다혜 on 2023/08/28.
//

import UIKit
import SeSACPhotoFramework

//Protocol 값 전달 1.
protocol PassDataDelegate {
    func receiveDate(date: Date)
}

protocol PassImageDelegate {
    func receiveImage(image: String)
}

class AddViewController: BaseViewController {

    let mainView = Addview()

    override func loadView() {  // viewDidLoad 보다 먼저 호출됨, super 메서드 호출X
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        ClassOpenExample.publicExample()
        ClassPublicExample.publicExample()
        //ClassInternalExample.publicExample()
        APIService.shared.request()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: .selectImage, object: nil)

        //sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "hello", text: "hi")
    }

    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .selectImage, object: nil)
    }

    @objc func selectImageNotificationObserver(notificatoin: NSNotification) {
        print("selectImageNotificationObserver")

        if let name = notificatoin.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
        
    }

    @objc func searchButtonClicked() {

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let gallery = UIAlertAction(title: "갤러리에서 가져오기", style: .default) { _ in
            let picker = UIImagePickerController()

            guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true

            self.present(picker, animated: true)
        }
        let web = UIAlertAction(title: "웹에서 가져오기", style: .default) { _ in
            self.present(SearchViewController(), animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(gallery)
        alert.addAction(web)
        alert.addAction(cancel)

        present(alert, animated: true)

//        let word = ["Apple", "Banana", "Cookie", "Cake", "Sky"]
//
//        NotificationCenter.default.post(name: NSNotification.Name("RecommandKeyword"), object: nil, userInfo: ["word" : word.randomElement()!])
    }

    @objc func dateButtonClicked() {
        let vc = DateViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func searchProtocolButtonClicked() {
        let vc = SearchViewController()

        vc.delegate = self
        present(vc, animated: true)
    }

    @objc func titleButtonClicked() {
        let vc = TitleViewController()

        //Closure - 3.
        vc.completionHandler = { title, age, push in
            self.mainView.titleButton.setTitle(title, for: .normal)
            print("completionHandler",age , push)
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func contentButtonClicked() {
        let vc = ContentViewController()

        vc.handler = { text in
            self.mainView.contentButton.setTitle(text, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    override func configureView() {
        super.configureView()
        print("Add configureView")
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        mainView.contentButton.addTarget(self, action: #selector(contentButtonClicked), for: .touchUpInside)
    }

    override func setConstraints() {
        super.setConstraints()
        print("Add setConstraints")

    }
}

//Protocol 값 전달 4.
extension AddViewController: PassDataDelegate, PassImageDelegate {

    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }

    func receiveImage(image: String) {
        mainView.photoImageView.image = UIImage(systemName: image)
    }

}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.mainView.photoImageView.image = image
            dismiss(animated: true)
        }
    }

}


