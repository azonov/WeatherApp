//
//  BazierCurves.swift
//  WeatherApp
//
//  Created by Admin on 18.01.17.
//  Copyright © 2017 VSU. All rights reserved.
//

import UIKit

class BazierCurves: UIView {

    override func draw(_ rect: CGRect) {
        /*Drawing Axis*/
        let zeroDot: CGPoint = CGPoint(x: 5, y: self.bounds.height / 2)
        
        let axisPath = UIBezierPath()
        axisPath.move(to: zeroDot)
        
        axisPath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height / 2))
        axisPath.move(to: zeroDot)
        axisPath.addLine(to: CGPoint(x: 5, y: 0))
        axisPath.move(to: zeroDot)
        axisPath.addLine(to: CGPoint(x: 5, y: self.bounds.height))
        axisPath.move(to: zeroDot)
        
        let blackColor = UIColor.black
        blackColor.setStroke()
        
        axisPath.lineWidth = 3.0
        axisPath.stroke()
        
        /*Drawing temperature graph*/
        let leftDot: CGPoint = CGPoint(x: 5, y: self.bounds.height / 2 - CGFloat(avgTemperatures[0]) * 5.5)
        
        let dot1: CGPoint = CGPoint(x: self.bounds.width / 6, y: self.bounds.height / 2 - CGFloat(avgTemperatures[1]) * 5.5)
        let dot2: CGPoint = CGPoint(x: 2*self.bounds.width / 6, y: self.bounds.height / 2 - CGFloat(avgTemperatures[2]) * 5.5)
        let dot3: CGPoint = CGPoint(x: 3*self.bounds.width / 6, y: self.bounds.height / 2 - CGFloat(avgTemperatures[3]) * 5.5)
        let dot4: CGPoint = CGPoint(x: 4*self.bounds.width / 6, y: self.bounds.height / 2 - CGFloat(avgTemperatures[4]) * 5.5)
        let dot5: CGPoint = CGPoint(x: 5*self.bounds.width / 6, y: self.bounds.height / 2 - CGFloat(avgTemperatures[5]) * 5.5)
        let dot6: CGPoint = CGPoint(x: self.bounds.width - 5, y: self.bounds.height / 2 - CGFloat(avgTemperatures[6]) * 5.5)
        
        let dropPath = UIBezierPath()
        dropPath.move(to: leftDot)
        
        dropPath.addLine(to: dot1)
        dropPath.move(to: dot1)
        dropPath.addLine(to: dot2)
        dropPath.move(to: dot2)
        dropPath.addLine(to: dot3)
        dropPath.move(to: dot3)
        dropPath.addLine(to: dot4)
        dropPath.move(to: dot4)
        dropPath.addLine(to: dot5)
        dropPath.move(to: dot5)
        dropPath.addLine(to: dot6)
        dropPath.move(to: dot6)
        
        
        let blueColor = UIColor.blue
        
        blueColor.setStroke()
        dropPath.lineWidth = 2.0
        
        dropPath.stroke()
    }

}
