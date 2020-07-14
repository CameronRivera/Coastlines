import UIKit
import Charts
import AVFoundation

class LocationDetailController: UIViewController {
    
    private var locationView = DetailView()
    private let location: Location
    private var selection: Selection
    private var tocCell = TOCCell()
    private var didYouKnowCell = ContentCell()
    private var meansCell = ContentCell()
    private var willWeGoCell = ContentCell()
    private var seaChartCell = GraphCell()
    private var pieChartCell = PieChartCell()
    private var augCell = ARCell()
    private var buttonTag = 0
    private var didYouKnowText: [String]
    private var whatsHappeningText: [String]
    private var whereWillWeGoText: [String]
    
    init(_ location: Location) {
        self.location = location
        self.selection = Selection(selected: self.location.name)
        self.didYouKnowText = location.getDidYouKnowText()
        self.whatsHappeningText = location.getWhatsHappeningText()
        self.whereWillWeGoText = location.getWhereWillWeGoText()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = locationView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PaletteColour.darkBlue.colour
        
        setupUIandTargets()
        showHideItems()
        locationView.collectionView.delegate = self
        locationView.collectionView.dataSource = self
    }
    
    private func setupUIandTargets() {
        locationView.goToARButton.addTarget(self, action: #selector(goToARButtonPressed(_:)), for: .touchUpInside)
        locationView.backButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        locationView.infoButton.addTarget(self, action: #selector(infoButtonPressed(_:)), for: .touchUpInside)
        locationView.nextButton.addTarget(self, action: #selector(nextButtonPressed(_:)), for: .touchUpInside)
        locationView.prevButton.addTarget(self, action: #selector(prevButtonPressed(_:)), for: .touchUpInside)
        
        locationView.imageOne.image = UIImage(named: location.images.one)
        locationView.locationLabel.text = location.name
        
        locationView.imageOne.addAccessibility(.image, location.images.accessibility, nil, "")
        locationView.collectionView.isScrollEnabled = false
    }
    
    @objc func goToARButtonPressed(_ sender: UIButton?) {
        
        if selection != .newYork {
            
            let comingSoonAlert = makeAlert("\n\nComing Soon!!!", "\n\nAn Augmented Reality Experience for \(location.name) is on its way", Font.boldArial26, PaletteColour.darkBlue.colour)
            comingSoonAlert.setMessage(font: Font.boldArial24, color: PaletteColour.darkBlue.colour)
            
            present(comingSoonAlert, animated: true, completion: nil)
            
        } else {
//            let arVC = ExperimentARController(location)
//            UIViewController.resetWindow(arVC)
        }
        
    }
    
    @objc func backButtonPressed(_ sender: UIButton) {
        
        let locationsVC = LocationsViewController()
        UIViewController.resetWindow(locationsVC)
    }
    
    @objc func infoButtonPressed(_ sender: UIButton) {
        
        let resourcesVC = ResourcesController()
        UIViewController.resetWindow(resourcesVC)
    }
    
    @objc func nextButtonPressed(_ sender: UIButton) {
        scrollRightTo(isToc: false)
        buttonTag += 1
        showHideItems()
        print(buttonTag)
    }
    
    @objc func prevButtonPressed(_ sender: UIButton) {
        scrollLeftTo()
        buttonTag -= 1
        showHideItems()
        print(buttonTag)
    }
    
    private func showHideItems() {
        switch buttonTag {
        case 0:
            tocCell.showItems()
            locationView.hidePrev()
            didYouKnowCell.hideLabels()
        case 1:
            tocCell.hideItems()
            locationView.showPrev()
            didYouKnowCell.showLabels()
            seaChartCell.hideItems()
        case 2:
            locationView.showPrev()
            seaChartCell.showItems()
            animateChart()
            didYouKnowCell.hideLabels()
            meansCell.hideLabels()
        case 3:
            seaChartCell.hideItems()
            meansCell.showLabels()
            pieChartCell.hideItems()
        case 4:
            pieChartCell.showItems()
            meansCell.hideLabels()
            willWeGoCell.hideLabels()
        case 5:
            pieChartCell.hideItems()
            locationView.showPrev()
            locationView.showNext()
            willWeGoCell.showLabels()
            augCell.hideItems()
        //            locationView.showARButton()
        case 6:
            willWeGoCell.hideLabels()
            locationView.hideNext()
            locationView.showPrev()
            //            locationView.hideARButton()
            augCell.showItems()
            augCell.arIconAnimation.play()
            augCell.arIconAnimation.loopMode = .loop
        default:
            locationView.showPrev()
        }
    }
    
    private func scrollRightTo(time: Double = 1.0, isToc: Bool) {
        
        var notInstant = 0.0
        
        UIView.animate(withDuration: time*(1), delay: 0, options: .curveEaseOut, animations: {
            self.locationView.nameLabelLeading.constant -= self.locationView.frame.width+8
            self.locationView.wavyLeading.constant -= self.locationView.frame.width
            self.locationView.layoutIfNeeded()
        }, completion: nil)
        
        if !isToc {
            notInstant = time
        }
        
        UIView.animate(withDuration: notInstant*(1), delay: 0, options: .curveEaseOut, animations: {
            self.locationView.collectionView.contentOffset.x += self.locationView.frame.width-5.5
            self.locationView.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    private func scrollLeftTo() {
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.locationView.collectionView.contentOffset.x -= self.locationView.frame.width-5.5
            self.locationView.nameLabelLeading.constant += self.locationView.frame.width+8
            self.locationView.wavyLeading.constant += self.locationView.frame.width
            self.locationView.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func animateChart() {
        seaChartCell.seaLevelLineChart.animate(xAxisDuration: 2, yAxisDuration: 3, easingOption: .easeInCirc)
    }
    
    private func setSeaLevelChart() {
        seaChartCell.location = location
        seaChartCell.setSeaLevelData()
        seaChartCell.seaLevelSet.setCircleColor(PaletteColour.darkBlue.colour)
        seaChartCell.seaLevelSet.setColor(PaletteColour.darkBlue.colour)
        seaChartCell.seaLevelSet.fill = Fill(color: PaletteColour.darkBlue.colour)
        seaChartCell.headerLabel.addAccessibility(.none, "This is a line chart that shows how sea levels might rise from now until 2100. It is even possible that by the year 2100 sea levels could surpass 6 feet.", nil, "Tapping on this chart displays a pop up view for the rise in sea level for the selected year")
    }
}

extension LocationDetailController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let arCell = collectionView.dequeueReusableCell(withReuseIdentifier: "arCell", for: indexPath) as? ARCell else {
            fatalError("Failed to create AR Cell.")
        }
        
        switch indexPath.row {
        case 0:
            tocCell = configureTOCCell(collectionView, indexPath, self)
            return tocCell
            
        case 1:
            didYouKnowCell = configureContentCell(collectionView, indexPath, didYouKnowText)
            return didYouKnowCell
            
        case 2:
            seaChartCell = configureLina(collectionView, indexPath, self, location)
            return seaChartCell
            
        case 3:
            meansCell = configureContentCell(collectionView, indexPath, whatsHappeningText)
            return meansCell
            
        case 4:
            pieChartCell = configurePieChartCell(collectionView, indexPath, location)
            return pieChartCell
            
        case 5:
            willWeGoCell = configureContentCell(collectionView, indexPath, whereWillWeGoText)
            return willWeGoCell
            
        case 6:
            augCell = arCell
            return augCell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  locationView.collectionView.configureCellSize(1, 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 6 {
            goToARButtonPressed(nil)
        } else if indexPath.row == 4 {
            let (fact1,fact2) = FactText.getFact(selection)
            let showAlert = makeAlert(fact1, fact2, Font.boldArial26, PaletteColour.darkBlue.colour)
            
            self.present(showAlert, animated: true, completion: nil)
        }
    }
}

extension LocationDetailController: TapContents {
    func onItem(content: Content) {
        
        scrollHelper(to: content.rawValue)
        buttonTag = content.rawValue
        
        locationView.showPrev(delay: TimeInterval(content.rawValue)*0.5)
        
        if content == .seeInAR {
            //            locationView.hideARButton()
            locationView.hideNext()
            augCell.arIconAnimation.play()
            augCell.arIconAnimation.loopMode = .loop
        }
    }
    
    private func scrollHelper(to: Int) {
        tocCell.hideItems()
        
        switch to {
        case 1:
            didYouKnowCell.showLabels()
        case 2:
            seaChartCell.showItems()
        case 3:
            meansCell.showLabels()
        case 4:
            pieChartCell.showItems()
        case 5:
            willWeGoCell.showLabels()
        case 6:
            augCell.showItems()
        default:
            break
        }
        for _ in 1...to {
            scrollRightTo(time: Double(to)*0.8, isToc: true)
        }
    }
}

extension LocationDetailController: GraphClicked {
    
    func clickedOnGraph(year: Double, rise: Double) {
        let showAlert = GraphShowAlert.makeAlert(year: year, rise: rise, vc: self)
        self.present(showAlert, animated: true, completion: nil)
    }
    
}
