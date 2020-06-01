//
//  LocationDetailVC.swift
//  Coastlines
//
//  Created by Kelby Mittan on 5/26/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import Charts

class LocationDetailVC: UIViewController {
    
    private var locationView = LocationDetailView()
    
    private let locations = FactsData.getLocations()
    
    private var isStatusBarHidden = false
    
    private var animateSLGraphCalled = false
    
    private var seaLevelSet = LineChartDataSet()
    
    override var prefersStatusBarHidden: Bool {
        return self.isStatusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override func loadView() {
        view = locationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        
        locationView.goToARButton.addTarget(self, action: #selector(goToARButtonPressed(_:)), for: .touchUpInside)
        locationView.backButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        locationView.scrollView.delegate = self
        locationView.seaLevelLineChart.delegate = self
        locationView.populationGraphView.delegate = self
        setupUI()
        setSeaLevelData()
        
        
    }
    
    private func setupUI() {
        let nyc = locations[0]
        locationView.locationLabel.text = nyc.location
        locationView.seaLevelContentLabel.text = nyc.facts.generalFacts
        locationView.looksLikeContentLabel.text = nyc.facts.seaLevelFacts
        locationView.populationContentLabel.text = nyc.facts.populationFacts
    }
    
    
    @objc func goToARButtonPressed(_ sender: UIBarButtonItem) {
        
        print("AR Button Pressed")
        
        let arVC = ARViewController()
        present(arVC, animated: true)
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem) {
        
        print("Back Button Pressed")
        
        setSeaLevelData()
        //        locationView.seaLevelLineChart.animate(xAxisDuration: 4)
        //        locationView.seaLevelLineChart.animate(xAxisDuration: 2, yAxisDuration: 6.5, easingOption: .easeInCirc)
        locationView.seaLevelLineChart.animate(xAxisDuration: 10)
    }
}

extension LocationDetailVC: UIScrollViewDelegate {
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.7) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let y: CGFloat = scrollView.contentOffset.y
        
        print(locationView.triggerSLView2.frame.height - locationView.triggerSLView1.frame.height)
        
        if y > 60 {
            isStatusBarHidden = true
            animateStatusBar()
        } else {
            isStatusBarHidden = false
            animateStatusBar()
        }
        
        triggerGraphAnimation()
        
    }
    
    func triggerGraphAnimation() {
        let triggerHeight = locationView.triggerSLView2.frame.height - locationView.triggerSLView1.frame.height
        if triggerHeight > 10 && triggerHeight < 20 && !animateSLGraphCalled {
            setSeaLevelData()
            seaLevelSet.setCircleColor(.white)
            seaLevelSet.setColor(.white)
            seaLevelSet.fill = Fill(color: .white)
            locationView.seaLevelLineChart.animate(xAxisDuration: 2, yAxisDuration: 2, easingOption: .easeInCirc)
            animateSLGraphCalled = true
        }
    }
    
}

extension LocationDetailVC: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setSeaLevelData() {
        seaLevelSet = LineChartDataSet(entries: getSeaLevelData())
        seaLevelSet.circleRadius = 3
        seaLevelSet.drawCirclesEnabled = false
        seaLevelSet.mode = .cubicBezier
        seaLevelSet.lineWidth = 3
        seaLevelSet.setCircleColor(.clear)
        seaLevelSet.setColor(.clear)
        seaLevelSet.fill = Fill(color: .clear)
        seaLevelSet.fillAlpha = 0.6
        seaLevelSet.drawFilledEnabled = true
        seaLevelSet.drawHorizontalHighlightIndicatorEnabled = false
        seaLevelSet.drawVerticalHighlightIndicatorEnabled = false
        let data = LineChartData(dataSet: seaLevelSet)
        data.setDrawValues(false)
        locationView.seaLevelLineChart.data = data
    }
    
    func getSeaLevelData() -> [ChartDataEntry] {
        var dataEntry: [ChartDataEntry] = []
        
        for data in locations[0].dataSet {
            let entry = ChartDataEntry(x: Double(data.year), y: data.level)
            dataEntry.append(entry)
        }
        return dataEntry
    }
}
