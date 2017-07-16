//
//  UISticky.swift
//  Stickies
//
//  Created by Glenn R. Golden on 9/11/16.
//  Copyright © 2016 Objects In Space. All rights reserved.
//

import UIKit
import CoreGraphics

class UISticky : UILabel, UIGestureRecognizerDelegate
{
	var sticky: Sticky
	
	var onMove : () -> Void
	var onGrab : (UISticky, Sticky) -> Void
	
	var longPress = false
	
	init(sticky: Sticky, onMove: @escaping () -> Void, onGrab: @escaping (UISticky, Sticky) -> Void)
	{
		self.sticky = sticky
		self.onMove = onMove
		self.onGrab = onGrab
		
		super.init(frame: sticky.frame)
		
		textColor = .black
		backgroundColor = UIColor(red: 255/255, green: 214/255, blue: 153/255, alpha: 1)
		textAlignment = .center
		text = "\(sticky)"
		isUserInteractionEnabled = true
		makeMovable()
		makeStuckDropshadow()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func makeMovable()
	{
		let panRec = UIPanGestureRecognizer()
		panRec.addTarget(self, action: #selector(UISticky.panAction))
		addGestureRecognizer(panRec)
		
		//		let pinchRec = UIPinchGestureRecognizer()
		//		pinchRec.addTarget(self, action: #selector(UISticky.pinchAction))
		//		addGestureRecognizer(pinchRec)
		
		let tapRec = UITapGestureRecognizer()
		tapRec.addTarget(self, action: #selector(UISticky.tapAction))
		addGestureRecognizer(tapRec)
		
		//		let swipeRec = UISwipeGestureRecognizer()
		//		swipeRec.addTarget(self, action: #selector(UISticky.swipeAction))
		//		addGestureRecognizer(swipeRec)
		
		let longPressRec = UILongPressGestureRecognizer()
		longPressRec.addTarget(self, action: #selector(UISticky.longPressAction))
		addGestureRecognizer(longPressRec)
		longPressRec.delegate = self
	}
	
	func makeStuckDropshadow()
	{
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.5
		layer.shadowOffset = CGSize(width:4.0, height:4.0)
		layer.shadowRadius = 4.0
		let shadowRect = CGRect(origin: bounds.origin,
		                        size: CGSize(width: bounds.width, height: bounds.height * 1.05))
		layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
	}
	
	func makeFloatingDropshadow()
	{
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.5
		layer.shadowOffset = CGSize(width:24.0, height:24.0)
		layer.shadowRadius = 4.0
		let shadowRect = CGRect(origin: bounds.origin,
		                        size: CGSize(width: bounds.width, height: bounds.height * 1.05))
		layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
	}
	
	func panAction(recognizer: UIPanGestureRecognizer)
	{
		if (!longPress)
		{
			return
		}
		
		if (recognizer.state == .changed)
		{
			let translation = recognizer.translation(in: self)
			recognizer.setTranslation(CGPoint(x: 0,y: 0), in: self)
			center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
			
			sticky.frame = frame
			onMove()
		}
	}
	
	func pinchAction(recognizer: UIPinchGestureRecognizer)
	{
		if (recognizer.state == .began)
		{
			// print("pinch scale \(recognizer.scale) velocity \(recognizer.velocity) - \(recognizer)")
			if (recognizer.velocity < 0) {
				print("pinch in")
			} else {
				print("pinch out")
			}
		}
	}
	
	func tapAction(recognizer: UITapGestureRecognizer)
	{
		if (recognizer.state == .ended)
		{
			print("touch");
		}
		// print(recognizer);
	}
	
	func swipeAction(recognizer: UISwipeGestureRecognizer)
	{
		print(recognizer);
	}
	
	func longPressAction(recognizer: UISwipeGestureRecognizer)
	{
		if (recognizer.state == .began)
		{
			print("long press began")
			longPress = true
			makeFloatingDropshadow()
			onGrab(self, sticky)
		}
		else if (recognizer.state == .ended)
		{
			print("long press ended")
			longPress = false
			makeStuckDropshadow()
		}
		// print(recognizer);
	}
	
	// MARK: UIGestureRecognizerDelegate
	
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
	                       shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
	{
		return (otherGestureRecognizer is UIPanGestureRecognizer)
	}
}
