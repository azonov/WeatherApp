//
//  ParserProtocol.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation

protocol ParserProtocol {
    static func parser(service : SupportedServices) -> ParserProtocol
    func populate(object: LocationMO, withJson json:Any) throws
}
