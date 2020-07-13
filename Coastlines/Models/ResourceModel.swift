//
//  ResourceModel.swift
//  Coastlines
//
//  Created by Brendon Cecilio on 6/15/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import Foundation

struct Resource {
    var title: String
    var description: String
    var link: String
    
    static func getResources() -> [Resource] {
        return [
            Resource(title: "Bike to Work!", description: "\u{2022} To help, we've rounded up our best tips for eco-friendly commuting, starting a carpool, commuting by bike, and much more in this guide. You'll save money, time, and reduce your carbon footprint -- and could even lose weight! Learn more.", link: ""),
            Resource(title: "Daily Actions You Can Take.", description: "\u{2022} The number one goal? Limiting the use of fossil fuels such as oil, carbon and natural gas and replacing them with renewable and cleaner sources of energy. This includes driving and flying less, switching to a ‘green’ energy provider. Learn more.", link: ""),
            Resource(title: "Considering Solar Energy.", description: "\u{2022} Renewables like wind and solar are becoming increasingly cheap across the world. The cost of utility-scale solar panels has fallen 73 percent since 2010, for example, making solar energy the cheapest source of electricity for many households in Latin America, Asia and Africa. In the UK, onshore wind and solar are competitive with gas and by 2025 will be the cheapest source of electricity generation. Learn more.", link: ""),
            Resource(title: "Can my diet make a difference?", description: "\u{2022} After fossil fuels, the food industry is one of the most important contributors to climate change. By reducing your consumption of animal protein by half you will cut your diet's carbon footprint by more than 40%. Learn more.", link: ""),
            Resource(title: "Can't afford to cut down?", description: "\u{2022} If you simply can’t make every change that’s needed, consider offsetting your emissions with a trusted green project – not a ‘get out of jail free card’, but another resource in your toolbox to compensate that unavoidable flight or car trip. Learn more.", link: ""),
            Resource(title: "Attend a rally.", description: "\u{2022} Recent climate strikes have shown that we have the people power we need to solve the climate crisis and end the age of fossil fuels. Learn more.", link: "")
        ]
    }
}
