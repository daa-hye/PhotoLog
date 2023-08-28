//
//  BaseCollectionViewCell.swift
//  PhotoLog
//
//  Created by 박다혜 on 2023/08/28.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() { }
    func setConstraints() { }
}
