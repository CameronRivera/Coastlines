//
//  ResourceCell.swift
//  Coastlines
//
//  Created by Brendon Cecilio on 6/15/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

class ResourceCell: UITableViewCell {
    
    var data: Resources? {
        didSet {
            guard let data = data else {
                return
            }
            self.title.text = data.title
            self.subtext.text = data.description
        }
    }
    
    private var titleHeightConstraint = NSLayoutConstraint()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
        
    private lazy var subtext: UITextView = {
        let tv = UITextView()
        tv.text = ""
        tv.font = UIFont.preferredFont(forTextStyle: .body)
        tv.adjustsFontForContentSizeCategory = true
        tv.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        tv.isUserInteractionEnabled = true
        tv.isEditable = false
        tv.isSelectable = true
        tv.dataDetectorTypes = UIDataDetectorTypes.link
        tv.textAlignment = .left
        tv.backgroundColor = UIColor.clear
        return tv
    }()
    
    private lazy var container: UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.backgroundColor = PaletteColour.lightBlue.colour
        v.layer.cornerRadius = 12
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupContainer()
        setupTitle()
        setupSubText()
    }
    
    private func setupContainer() {
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1)
        ])
    }
    
    private func setupTitle() {
        container.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            //title.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    private func setupSubText() {
        container.addSubview(subtext)
        subtext.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtext.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            subtext.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            subtext.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15),
            subtext.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5)
//            subtext.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    public func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1,options: [.curveEaseIn], animations: {
            self.contentView.layoutIfNeeded()
        })
    }
    
    public func configureCell(with resource: Resources) {
        title.text = resource.title
        let attString = NSMutableAttributedString(string: resource.description, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)])
        let url = "https://www.apple.com"
        attString.setAttributes([.link: url, NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)], range: NSMakeRange(attString.length - 11, 11))
        subtext.attributedText = attString
    
        title.addAccessibility(.none, resource.title, nil, nil)
        subtext.addAccessibility(.none, resource.description, nil, nil)
    }
}
