//
//  ResourceView.swift
//  Coastlines
//
//  Created by Brendon Cecilio on 6/15/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

class ResourceView: UIView {
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    public lazy var prevButton: UIButton = {
       let button = UIButton()
        button.setTitle("", for: .normal)
        button.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)

        button.tintColor = PaletteColour.darkBlue.colour
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        button.addAccessibility(.button, "Back", nil, "Returns to the locations screen.")
        return button
    }()
    
    public lazy var header: UILabel = {
        let label = UILabel()
        label.text = "Actions"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.addAccessibility(.none, "Actions", nil, nil)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupPrevButton()
        setupHeader()
        setupTableView()
    }
    
    private func setupPrevButton() {
        addSubview(prevButton)
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            prevButton.topAnchor.constraint(equalTo: topAnchor, constant: 35),
            prevButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            prevButton.widthAnchor.constraint(equalToConstant: 38),
            prevButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupHeader() {
        addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: prevButton.bottomAnchor, constant: 13),
            header.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    @objc private func goBack() {
        
        let locationVC = LocationsViewController()
        UIViewController.resetWindow(locationVC)
    }
    
}
