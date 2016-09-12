//
//  ViewController.swift
//  Stickies
//
//  Created by Glenn R. Golden on 9/11/16.
//  Copyright © 2016 Objects In Space. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var wallLabel: UILabel!
	
	// a sticky wall
	let wall: Wall = Wall()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// intialize the sticky id base
		Sticky.nextId = 22
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// UI add button pressed - add a new sticky to our wall
	@IBAction func addSticky(_ sender: UIButton)
	{
		// add the new sticky
		let sticky = Sticky()
		wall.addSticky(sticky)
		
		addStickyUI(sticky)
		
		// update the wall title count
		wallLabel.text = "Wall ( \(wall.count) )"
		
		// debug
		print(wall)
	}
	
	func addStickyUI(_ sticky:Sticky)
	{
		let ui = UISticky(origin: CGPoint(x: 16, y: 50), sticky: sticky)
		self.view.addSubview(ui)
	}
}
