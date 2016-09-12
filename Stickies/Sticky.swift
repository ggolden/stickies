//
//  Sticky.swift
//  Stickies
//
//  Created by Glenn R. Golden on 9/11/16.
//  Copyright © 2016 Objects In Space. All rights reserved.
//

import Foundation

class Sticky: CustomStringConvertible
{
	// next id to allocate
	static var nextId = 1
	
	// unique ID
	var id = 0
	
	var description: String
	{
		return "Sticky ID: \(id)"
	}
	
	init()
	{
		// allocate the next id
		id = Sticky.nextId
		Sticky.nextId += 1
	}
}
