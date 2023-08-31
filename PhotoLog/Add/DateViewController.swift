//
//  DateViewController.swift
//  PhotoLog
//
//  Created by 박다혜 on 2023/08/29.
//

import Foundation

class DateViewController: BaseViewController {

    let mainView = DateView()

    //Protocol 값 전달 2.
    var delegate: PassDataDelegate?

    override func loadView() {
        self.view = mainView
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //Protocol 값 전달 3.
        delegate!.receiveDate(date: mainView.datePicker.date)
    }

}
