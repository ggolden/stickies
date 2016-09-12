//
//  Wall.swift
//  Stickies
//
//  Created by Glenn R. Golden on 9/11/16.
//  Copyright © 2016 Objects In Space. All rights reserved.
//

import Foundation

class Wall: CustomStringConvertible
{
	// unique ID
	var id = 0
	
	// stickies on this wall
	var stickies: [Sticky] = []
	
	var description: String
	{
		return "Wall ID: \(id) Stickies: \(stickies)"
	}
	
	// how many stickies has this wall?
	var count: Int
	{
		return stickies.count
	}
	
	// add a new sticky to the wall
	func addSticky(_ sticky: Sticky)
	{
		stickies.append(sticky);
	}
}
