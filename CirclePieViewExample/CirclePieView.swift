//
//  CirclePieView.swift
//  CirclePieViewExample
//
//  Created by Mark Jackson on 10/8/15.
//  Copyright © 2015 Mark Jackson. All rights reserved.
//

import UIKit

@IBDesignable class CirclePieView: UIView {
    
    //Values for each segment
    private var segmentValues : [Float]
    //Total for each segment
    private var segmentTotals : [Float]
    //Color for each segment
    private var segmentColors : [UIColor]
    //Sum of each segmentTotals element
    private var segmentTotalAll : Float
    
    //When creating the view in code
    override init(frame: CGRect) {
        segmentValues = []
        segmentTotals = []
        segmentColors = []
        segmentTotalAll = 0
        super.init(frame: frame)
    }
    
    //When creating the view in IB
    required init?(coder aDecoder: NSCoder) {
        segmentValues = []
        segmentTotals = []
        segmentColors = []
        segmentTotalAll = 0
        super.init(coder: aDecoder)
    }
    
    //Sets all the segment members in order to draw each segment
    func setSegmentValues(values : [Int], totals : [Int], colors : [UIColor]){
        //Must be equal lengths
        if values.count != totals.count && totals.count != colors.count{
            return;
        }
        //Set the colors
        segmentColors = colors
        segmentTotalAll = 0
        for total in totals {
            segmentTotalAll += Float(total)
            segmentTotals.append(Float(total))
        }
        for val in values {
            segmentValues.append(Float(val))
        }
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        //Base circle
        UIColor.black.setFill()
        let outerPath = UIBezierPath(ovalIn: rect)
        outerPath.fill()
        
        
        //Semicircles
        //self.frame isn't defined yet, so we can't use self.center
        let viewCenter = CGPoint(x: rect.width / 2, y: rect.height / 2)
        var i = 0
        var lastAngle :Float = 0.0
        let baseCircleRadius = rect.width / 2
        let centerCircleRadius = rect.width / 2 * 0.55
        
        //value : current number
        for value in segmentValues {
            //total : total number
            let total = segmentTotals[safe: i]!
            
            //offsetTotal : difference between Base Circle and Center Circle
            let offset =  baseCircleRadius - centerCircleRadius
            
            //radius : radius of segment
            let radius = CGFloat(value / total) * offset + centerCircleRadius
            //startAngle : start angle of this segment
            let startAngle = lastAngle
            //endAngle : end angle of this segment
            let endAngle = lastAngle + total / segmentTotalAll * 360.0
            //color : color of the segment
            let color = segmentColors[safe: i]!
            color.setFill()
            
            let midPath = UIBezierPath()
            midPath.move(to: viewCenter)
            
            midPath.addArc(withCenter: viewCenter, radius: CGFloat(radius), startAngle: startAngle.degreesToRadians, endAngle: endAngle.degreesToRadians, clockwise: true)
            
            midPath.close()
            midPath.fill()
            
            lastAngle = endAngle
            i += 1
        }
        
        //Center circle
        UIColor.white.setFill()
        let centerPath = UIBezierPath(ovalIn: rect.insetBy(dx: centerCircleRadius, dy: centerCircleRadius))
        centerPath.fill()
        
        UIColor.gray.setStroke()
        let lineLength = centerCircleRadius * 0.5
        let strokePath = UIBezierPath()
        strokePath.lineWidth = 2
        strokePath.move(to: CGPoint(x: viewCenter.x - lineLength / 2, y: viewCenter.y))
        strokePath.addLine(to: CGPoint(x: viewCenter.x + lineLength / 2, y: viewCenter.y))
        strokePath.stroke()
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

extension Float {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(Double.pi) / 180.0
    }
}
