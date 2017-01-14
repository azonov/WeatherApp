//
//  WeatherState.swift
//  WeatherApp
//
//  Created by Andrey Volodin on 26.11.16.
//  Copyright © 2016 VSU. All rights reserved.
//

import UIKit

public enum WeatherState {
    case veryCold, cold, neutral, warm, hot
}

public extension WeatherState {
    public var color: UIColor {
        switch self {
        case .veryCold: return .blue
        case .cold:     return UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.5, alpha: 1.0)
        case .neutral:  return .green
        case .warm:     return .orange
        case .hot:      return .red
        }
    }
}

public extension WeatherState {
    // Assume integer is in Celsium
    public static func from(_ integer: Int) -> WeatherState {
        switch integer {
        case Int.min..<(-15): return .veryCold
        case (-15)..<(-5):    return .cold
        case (-5)..<15:       return .neutral
        case 15..<25:         return .warm
        case 25...Int.max:    return .hot
        default: fatalError("Given value does not conform to any weather state")
        }
    }
}
