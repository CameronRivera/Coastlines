//
//  LocationsVew.swift
//  Coastlines
//
//  Created by Brendon Cecilio on 5/27/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

class LocationsVew: UIView {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return collection
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
        
    }
}
