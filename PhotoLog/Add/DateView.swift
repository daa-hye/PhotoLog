//
//  DateView.swift
//  PhotoLog
//
//  Created by 박다혜 on 2023/08/29.
//

import UIKit

class DateView: BaseView {

    let datePicker = {
        let view = UIDatePicker()
        view.preferredDatePickerStyle = .wheels
        return view
    }()

    override func configureView() {
        addSubview(datePicker)
    }

    override func setConstraints() {
        datePicker.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
