//
//  Wall.swift
//  Stickies
//
//  Created by Glenn R. Golden on 9/11/16.
//  Copyright © 2016 Objects In Space. All rights reserved.
//

import Foundation

class Wall: NSObject, NSCoding
{
	struct PropertyKey {
		static let idKey = "id"
		static let nextStickyIdKey = "nextStickyId"
		static let stickiesKey = "stickies"
	}
	
	// unique ID
	var id = 0
	
	// next sticky id to allocate
	var nextStickyId = 1
	
	// stickies on this wall
	var stickies: [Sticky] = []
	
	override var description: String
	{
		return "Wall ID: \(id) Stickies: \(stickies)"
	}
	
	// how many stickies has this wall?
	var count: Int
	{
		return stickies.count
	}
	
	// designated initializer
	init(id: Int) {
		self.id = id
		
		super.init()
	}
	
	// convenience initializer with all properties
	convenience init(id: Int, nextStickyId: Int, stickies: [Sticky]) {
		self.init(id: id)
		
		self.nextStickyId = nextStickyId
		self.stickies = stickies
	}
	
	// add a new sticky to the wall
	func addSticky() -> Sticky
	{
		// allocate the next sticky id
		let id = nextStickyId
		nextStickyId += 1
		
		// create a new sticky
		let sticky = Sticky(id: id)
		
		stickies.append(sticky)
		
		return sticky
	}
	
	// move the sticky to the end (front most) of the array
	func promote(_ sticky: Sticky)
	{
		// pull sticky from within array, adding it to the end
		stickies = stickies.filter() { $0 !== sticky }
		stickies.append(sticky)
	}
	
	// MARK: Persistence
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(id, forKey: PropertyKey.idKey)
		aCoder.encode(nextStickyId, forKey: PropertyKey.nextStickyIdKey)
		aCoder.encode(stickies, forKey: PropertyKey.stickiesKey)
	}
	
	required convenience init?(coder aDecoder: NSCoder) {
		let id = aDecoder.decodeInteger(forKey: PropertyKey.idKey)
		let nextStickyId = aDecoder.decodeInteger(forKey: PropertyKey.nextStickyIdKey)
		let stickies = aDecoder.decodeObject(forKey: PropertyKey.stickiesKey) as! [Sticky]
		
		self.init(id: id, nextStickyId: nextStickyId, stickies: stickies)
	}
}
