//
//  ContentViewController.swift
//  PhotoLog
//
//  Created by 박다혜 on 2023/08/29.
//

import UIKit

class ContentViewController: BaseViewController {

    let textView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        return view
    }()

    var handler: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidDisappear(_ animated: Bool) {
        handler?(textView.text!)
    }

    override func configureView() {
        super.configureView()
        
        view.addSubview(textView)
    }

    override func setConstraints() {
        super.setConstraints()

        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(250)
        }
    }

}
