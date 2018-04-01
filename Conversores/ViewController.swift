//
//  ViewController.swift
//  Conversores
//
//  Created by Mauricio Miyamura on 31/03/18.
//  Copyright © 2018 Yuddi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbUnit1: UILabel!
    @IBOutlet weak var btUnit2: UIButton!
    @IBOutlet weak var tfResult: UILabel!
    
    enum UnitType: Int {
        case temperature, weight, currency, distance
    }
    var currentType: UnitType = .temperature
    
    var types: [UnitType: (type: String, units: [String])] =
        [UnitType.temperature: (type: "Temperatura", units: ["Celsius", "Fahrenheit"]),
         UnitType.weight: (type: "Peso", units: ["kg", "Libras"]),
         UnitType.currency: (type: "Moeda", units: ["Real", "Dólar"]),
         UnitType.distance: (type: "Distância", units: ["Metros", "km"])]
    
    var mValue = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func nextPrevious(_ sender: UIButton) {
        let unitsCount = types.count
        var newPosition: Int
        if sender.titleLabel!.text! == "<" {
            newPosition = (currentType.rawValue + unitsCount - 1) % unitsCount
        } else {
            newPosition = (currentType.rawValue + 1) % unitsCount
        }
        currentType = UnitType(rawValue: newPosition)!
        updateType()
        convert()
    }
    
    @IBAction func changeValue(_ sender: UITextField) {
        if let value = NumberFormatter().number(from: sender.text!) {
            mValue = Double(truncating: value)
        } else {
            mValue = 0.0
        }
        convert()
    }
    
    @IBAction func reverseUnits(_ sender: UIButton) {
        types[currentType]?.units.reverse()
        updateType()
        convert()
    }
    
    func updateType() {
        var (type, units) = types[currentType]!
        lbType.text = type
        lbUnit1.text = units[0]
        btUnit2.setTitle(units[1], for: .normal)
    }
    
    func convert() {
        var result: Double
        var precision: Double
        let fromUnit = types[currentType]!.units[0]
        
        switch currentType {
        case .temperature:
            if fromUnit == "Celsius" {
                result = 1.8 * mValue + 32.0
            } else {
                result = (mValue - 32) / 1.8
            }
            precision = 10.0
        case .weight:
            if fromUnit == "kg" {
                result = mValue * 2.2046226218
            } else {
                result = mValue / 2.2046226218
            }
            precision = 1000.0
        case .currency:
            if fromUnit == "Real" {
                result = mValue / 3.5
            } else {
                result = mValue * 3.5
            }
            precision = 100.0
        case .distance:
            if fromUnit == "Metros" {
                result = mValue / 1000.0
                precision = 1000.0
            } else {
                result = mValue * 1000.0
                precision = 1.0
            }
        }
        
        tfResult.text = String(round(result * precision) / precision)
    }
}

