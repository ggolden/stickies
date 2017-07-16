//
//  ViewController.swift
//  Stickies
//
//  Created by Glenn R. Golden on 9/11/16.
//  Copyright © 2016 Objects In Space. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	// documents stored here
	static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
	
	// the wall stored here
	static let ArchiveURL = URL(fileURLWithPath: "wall", isDirectory: false, relativeTo: DocumentsDirectory)
	
	@IBOutlet weak var wallLabel: UILabel!
	
	@IBOutlet weak var wallView: WallView!
	
	// a sticky wall - will likely be replaced by load
	var wall: Wall = Wall(id: 1)
	
	// the UI for each sticky
	var stickyUI : [UISticky] = []
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// load the wall
		load()
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// UI add button pressed - add a new sticky to our wall
	@IBAction func addSticky(_ sender: UIButton)
	{
		// add a new sticky to the wall
		let sticky = wall.addSticky()
		
		// add the sticky to the UI
		addStickyUI(sticky)
		
		// update the wall UI title count
		wallLabel.text = "Wall ( \(wall.count) )"
		
		// save
		save()
		
		// debug
		print(wall)
	}
	
	// UI clear button pressed - remove all stickies, if confirmed
	@IBAction func clearStickies(_ sender: UIButton)
	{
		// Create the alert controller
		let alertController = UIAlertController(title: "Confirm", message: "This will remove all stickies.", preferredStyle: .alert)
		
		// Create the actions
		let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
		{
			UIAlertAction in self.reset()
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
		
		// Add the actions
		alertController.addAction(okAction)
		alertController.addAction(cancelAction)
		
		// Present the controller
		self.present(alertController, animated: true, completion: nil)
	}
	
	// add a new sticky to the UI
	func addStickyUI(_ sticky: Sticky)
	{
		let ui = UISticky(sticky: sticky, onMove: save, onGrab: moveStickyFront)
		wallView.addSubview(ui)
		stickyUI.append(ui)
	}
	
	// move this sticky to in front of all others, data and UI
	func moveStickyFront(_ ui: UISticky, _ sticky: Sticky)
	{
		// promote it in the wall's order
		wall.promote(sticky);

		// promote it in the wall ui's subviews
		wallView.addSubview(ui)
		
		save()
	}
	
	// remove all stickies from data and UI
	func reset()
	{
		// remove all sticky UI objects from the wall view
		for ui in stickyUI
		{
			ui.removeFromSuperview()
		}
		stickyUI = []
		
		// clear the data
		wall = Wall(id: 1)
		
		// update the wall title count
		wallLabel.text = "Wall ( \(wall.count) )"
		
		// clear the archive
		clear()
	}
	
	// MARK: Persistence

	// save the wall data
	func save()
	{
		// print("Saving to \(ViewController.ArchiveURL.path)")
		let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(wall, toFile: ViewController.ArchiveURL.path)
		if !isSuccessfulSave
		{
			print("Failed to save wall.")
		}
	}
	
	// load the wall data, and recreated the UI
	func load()
	{
		if let wall = NSKeyedUnarchiver.unarchiveObject(withFile: ViewController.ArchiveURL.path) as? Wall
		{
			// TODO: if the old wall has stickies, they are in the UI and need to be removed
			
			// switch to this wall
			self.wall = wall;
			
			// establish the wall's UI
			for sticky in wall.stickies
			{
				addStickyUI(sticky)
			}
		}
	}
	
	func clear()
	{
		if FileManager().fileExists(atPath: ViewController.ArchiveURL.path)
		{
			do
			{
				try FileManager().removeItem(atPath:  ViewController.ArchiveURL.path)
			}
			catch let error as NSError
			{
				print("error: \(error)")
			}
		}
	}
}
