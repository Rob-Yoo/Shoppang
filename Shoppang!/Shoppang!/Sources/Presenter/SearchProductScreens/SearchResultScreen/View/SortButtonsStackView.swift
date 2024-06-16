//
//  SortButtonsStackView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit
import Then

enum SortType: String, CaseIterable {
    case sim
    case date
    case asc
    case dsc
    
    fileprivate var buttonTitle: String {
        switch self {
        case .sim:
            return "정확도"
        case .date:
            return "날짜순"
        case .asc:
            return "가격높은순"
        case .dsc:
            return "가격낮은순"
        }
    }
}

final class SortButtonsStackView: UIStackView {
    
    let sortButtons: [SortButton] = SortType.allCases.map {
        SortButton(title: $0.buttonTitle, type: $0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStackView() {
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 5
        self.sortButtons.forEach { self.addArrangedSubview($0) }
    }
}
