//
//  ViewController.swift
//  CirclePieViewExample
//
//  Created by Mark Jackson on 10/8/15.
//  Copyright © 2015 Mark Jackson. All rights reserved.
//

import UIKit

extension Double {
    func format(f: String) -> String {
        return NSString(format: "%\(f)f", self) as String
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var circlePieIndicatorView: CirclePieIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let values = [0, 150, 300, 0, 150, 300, 0, 150, 300, 0, 150, 300]
        var totalValues = 0
        for val in values {
            totalValues += val
        }
        let totals = [200, 500, 350, 220, 600, 500, 200, 500, 350, 220, 600, 500]
        var totalTotals = 0
        for total in totals {
            totalTotals += total
        }
        let percent = (Double(totalValues) / Double(totalTotals)) * 100
        circlePieIndicatorView.percentageLabel.text = percent.format(".0") + "%"
        circlePieIndicatorView.circlePieView.setSegmentValues(
            values,
            totals: totals,
            colors: [UIColor.greenColor(), UIColor.yellowColor(), UIColor.redColor(), UIColor.greenColor(), UIColor.yellowColor(), UIColor.redColor(), UIColor.greenColor(), UIColor.yellowColor(), UIColor.redColor(), UIColor.greenColor(), UIColor.yellowColor(), UIColor.redColor()])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

