//
//  PageSection.swift
//  Conversores
//
//  Created by Mauricio Miyamura on 01/04/18.
//  Copyright © 2018 Yuddi. All rights reserved.
//

struct PageSection {
    
    enum UnitType: Int {
        case temperature, weight, currency, distance
    }
    
    var type: UnitType
    
    var types: [UnitType: (name: String, units: [String])] =
        [UnitType.temperature: ("Temperatura", ["Celsius", "Fahrenheit"]),
         UnitType.weight: ("Peso", ["kg", "Libras"]),
         UnitType.currency: ("Moeda", ["Real", "Dólar"]),
         UnitType.distance: ("Distância", ["Metros", "km"])]
    
    var count: Int
    
    init(type: UnitType) {
        self.type = type
        self.count = types.count
    }
    
    mutating func next() {
        type = UnitType(rawValue: (type.rawValue + 1) % count)!
    }
    
    mutating func previous() {
        type = UnitType(rawValue: (type.rawValue + count - 1) % count)!
    }
    
    mutating func reverseUnits() {
        types[type]?.units.reverse()
    }
    
    func getTypeName() -> String {
        return types[type]!.name
    }
    
    func fromUnit() -> String {
        return types[type]!.units[0]
    }
    
    func toUnit() -> String {
        return types[type]!.units[1]
    }
    
    func convert(value: Double) -> (result: Double, precision: Double) {
        var result: Double
        var precision: Double
        
        switch type {
        case .temperature:
            if fromUnit() == "Celsius" {
                result = 1.8 * value + 32.0
            } else {
                result = (value - 32) / 1.8
            }
            precision = 10.0
        case .weight:
            if fromUnit() == "kg" {
                result = value * 2.2046226218
            } else {
                result = value / 2.2046226218
            }
            precision = 1000.0
        case .currency:
            if fromUnit() == "Real" {
                result = value / 3.5
            } else {
                result = value * 3.5
            }
            precision = 100.0
        case .distance:
            if fromUnit() == "Metros" {
                result = value / 1000.0
                precision = 1000.0
            } else {
                result = value * 1000.0
                precision = 1.0
            }
        }
        return (result, precision)
    }
}
