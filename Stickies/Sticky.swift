//
//  Sticky.swift
//  Stickies
//
//  Created by Glenn R. Golden on 9/11/16.
//  Copyright © 2016 Objects In Space. All rights reserved.
//

import Foundation
import UIKit

class Sticky: NSObject, NSCoding
{
	struct PropertyKey {
		static let idKey = "id"
		static let frameKey = "frame"
	}
	
	// unique ID
	var id = 0
	
	// position on wall
	var frame = CGRect(x: 0, y: 0, width: 200, height: 200)
	
	// designated initializer
	init(id: Int) {
		self.id = id
		
		super.init()
	}
	
	// convenience initializer with all properties
	convenience init(id: Int, frame: CGRect?) {
		self.init(id: id)
		if let f = frame {
			self.frame = f
		}
	}
	
	override var description: String
	{
		return "Sticky ID: \(id)"
	}
	
	// MARK: Persistence
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(id, forKey: PropertyKey.idKey)
		aCoder.encode(frame, forKey: PropertyKey.frameKey)
	}
	
	required convenience init?(coder aDecoder: NSCoder) {
		let id = aDecoder.decodeInteger(forKey: PropertyKey.idKey)
		let frame = aDecoder.decodeCGRect(forKey: PropertyKey.frameKey)
		
		self.init(id: id, frame: frame)
	}
}
