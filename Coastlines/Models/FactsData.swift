//
//  FactsData.swift
//  Coastlines
//
//  Created by Kelby Mittan on 5/30/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import Foundation

struct FactsData: Decodable {
    let results: [Location]
}

struct Location: Decodable {
    let name: String
    let facts: Facts
    let dataSet: [LocationData]
}

struct Facts: Decodable {
    let generalFacts: String
    let seaLevelFacts: String
    let populationFacts: String
    let population: Int
    let populationDisplaced: Int
}

struct DataSet: Decodable {
    let data: LocationData
}

struct LocationData: Decodable {
    let year: Int
    let level: Double
}

extension FactsData {
    
  static func getLocations() -> [Location] {
    var locations = [Location]()
    
    guard let fileURL = Bundle.main.url(forResource: "locationFactsData", withExtension: "json") else {
      fatalError("error getting json file")
    }
    do {
      let data = try Data(contentsOf: fileURL)
            
      let locationsData = try JSONDecoder().decode(FactsData.self, from: data)
      locations = locationsData.results
      
    } catch {
      fatalError("could not get locations: \(error)")
    }
    return locations
  }
  
}