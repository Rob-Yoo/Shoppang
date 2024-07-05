//
//  SortButtonsView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit
import SnapKit
import Then

protocol SortButtonsViewDelegate: AnyObject {
    func sortButtonTapped(type: SortType)
}

final class SortButtonsView: UIView {
    
    lazy var simButton = SortButton(type: .sim, isSelected: true).then {
        $0.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    lazy var dateButton = SortButton(type: .date).then {
        $0.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    lazy var dscButton = SortButton(type: .dsc).then {
        $0.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    lazy var ascButton = SortButton(type: .asc).then {
        $0.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    var allButtons: [SortButton] {
        return [simButton, dateButton, dscButton, ascButton]
    }
    
    weak var sortButtonsViewDelegate: SortButtonsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        self.addSubview(simButton)
        self.addSubview(dateButton)
        self.addSubview(dscButton)
        self.addSubview(ascButton)
    }
    
    private func configureLayout() {
        simButton.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
            $0.width.equalTo(60)
        }
        
        dateButton.snp.makeConstraints {
            $0.leading.equalTo(simButton.snp.trailing).offset(10)
            $0.verticalEdges.equalToSuperview()
            $0.width.equalTo(60)
        }
        
        dscButton.snp.makeConstraints {
            $0.leading.equalTo(dateButton.snp.trailing).offset(10)
            $0.verticalEdges.equalToSuperview()
            $0.width.equalTo(90)
        }
        
        ascButton.snp.makeConstraints {
            $0.leading.equalTo(dscButton.snp.trailing).offset(10)
            $0.verticalEdges.equalToSuperview()
            $0.width.equalTo(90)
        }
    }
    
    @objc func sortButtonTapped(sender: UIButton) {
        guard let delegate = sortButtonsViewDelegate else {
            print("SortButtonsViewDelegate 설정 후 사용해주세요")
            return
        }
        guard let sortButton = sender as? SortButton else { return }
        
        delegate.sortButtonTapped(type: sortButton.type)
        allButtons.forEach {
            $0.isSelected = ($0.type == sortButton.type) ? true : false
        }
    }
}
