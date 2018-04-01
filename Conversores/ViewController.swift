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
    
    var section = PageSection(type: .temperature)
    var mValue = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePage()
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
        if sender.titleLabel!.text! == "<" {
            section.previous()
        } else {
            section.next()
        }
        updatePage()
    }
    
    @IBAction func changeValue(_ sender: UITextField) {
        if let value = NumberFormatter().number(from: sender.text!) {
            mValue = Double(truncating: value)
        } else {
            mValue = 0.0
        }
        updatePage()
        
    }
    
    @IBAction func reverseUnits(_ sender: UIButton) {
        section.reverseUnits()
        updatePage()
    }
    
    func updatePage() {
        lbType.text = section.getTypeName()
        lbUnit1.text = section.fromUnit()
        btUnit2.setTitle(section.toUnit(), for: .normal)
        let (result, precision) = section.convert(value: mValue)
        tfResult.text = String(round(result * precision) / precision)
    }
    
}

