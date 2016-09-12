//
//  UISticky.swift
//  Stickies
//
//  Created by Glenn R. Golden on 9/11/16.
//  Copyright © 2016 Objects In Space. All rights reserved.
//

import UIKit

class UISticky : UILabel
{
	init(origin: CGPoint, sticky: Sticky)
	{
		let frame = CGRect(x: origin.x, y: origin.y, width: 200, height: 200)
		super.init(frame: frame)
		
		textColor = .black
		backgroundColor = UIColor(red: 255/255, green: 214/255, blue: 153/255, alpha: 1)
		textAlignment = .center
		text = "\(sticky)"
		isUserInteractionEnabled = true
		makeMovable()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func makeMovable()
	{
		let panRec = UIPanGestureRecognizer()
		panRec.addTarget(self, action: #selector(UISticky.panAction))
		addGestureRecognizer(panRec)
	}
	
	func panAction(recognizer: UIPanGestureRecognizer)
	{
		if (recognizer.state == .changed)
		{
			let translation = recognizer.translation(in: self)
			recognizer.setTranslation(CGPoint(x: 0,y: 0), in: self)
			center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
		}
	}
}
