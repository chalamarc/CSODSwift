//
//  ResponseJSONObjectSerializable.swift
//  csodSwiftREST
//
//  Created by Chalama Challa on 2015-11-29.
//

import Foundation
import SwiftyJSON

public protocol ResponseJSONObjectSerializable {
  init?(json: SwiftyJSON.JSON)
}
