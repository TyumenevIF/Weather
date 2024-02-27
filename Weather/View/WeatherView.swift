//
//  WeatherView.swift
//  Weather
//
//  Created by Ilyas Tyumenev on 27.02.2024.
//

import UIKit
import SnapKit

protocol WeatherViewDelegate: AnyObject {
    func weatherView(_ view: WeatherView, locationPressed sender: UIButton)
    func weatherView(_ view: WeatherView, searchPressed sender: UIButton)
}

final class WeatherView: UIView {
    
    // MARK: - let/var
    
    weak var delegate: WeatherViewDelegate?
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(locationPressed), for: .touchUpInside)
        return button
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 25)
        textField.backgroundColor = .systemFill
        textField.textAlignment = .right
        textField.placeholder = "Search"
        textField.minimumFontSize = 12
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .label
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var topStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        [self.locationButton,
         self.searchTextField,
         self.searchButton].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    let conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "weatherColor")
        return imageView
    }()
    
    let firstTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 80, weight: .black)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private let secondTempLabel: UILabel = {
        let label = UILabel()
        label.text = "°"
        label.font = .systemFont(ofSize: 100, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let thirdTempLabel: UILabel = {
        let label = UILabel()
        label.text = "C"
        label.font = .systemFont(ofSize: 100, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    lazy var tempStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        [self.firstTempLabel,
         self.secondTempLabel,
         self.thirdTempLabel].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .natural
        label.numberOfLines = 1
        return label
    }()
    
    private let clearView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.distribution = .fill
        stack.spacing = 10
        [self.topStackView,
         self.conditionImageView,
         self.tempStackView,
         self.cityLabel,
         self.clearView].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    // MARK: - lifecycle funcs
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - flow funcs
    
    private func setSubviews() {
        addSubview(backgroundImageView)
        addSubview(mainStackView)
    }
    
    private func setUpConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        locationButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        searchTextField.snp.makeConstraints { make in
        }
        
        searchButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        topStackView.snp.makeConstraints { make in
            make.leading.equalTo(mainStackView.snp.leading)
            make.trailing.equalTo(mainStackView.snp.trailing)
        }
        
        conditionImageView.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        firstTempLabel.snp.makeConstraints { make in
        }
        
        secondTempLabel.snp.makeConstraints { make in
        }
        
        thirdTempLabel.snp.makeConstraints { make in
        }
        
        tempStackView.snp.makeConstraints { make in
        }
        
        cityLabel.snp.makeConstraints { make in
        }
        
        clearView.snp.makeConstraints { make in
        }
                
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - extensions

private extension WeatherView {
    
    @objc func locationPressed(_ sender: UIButton) {
        delegate?.weatherView(self, locationPressed: sender)
    }
    
    @objc func searchButtonPressed(_ sender: UIButton) {
        delegate?.weatherView(self, searchPressed: sender)
    }
}
