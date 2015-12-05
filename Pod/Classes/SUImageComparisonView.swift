//
//  SwipeComparisonView.swift
//  ultrasound
//
//  Created by Sun on 11/17/2558 BE.
//  Copyright © 2558 Runnables. All rights reserved.
//

import UIKit

@IBDesignable
class SUImageComparisonView: UIView {
    
    var _primaryImage:UIImage?
    var _secondaryImage:UIImage?
    
    var _primaryImageView:UIImageView?
    var _secondaryImageView:UIImageView?
    
    var _barColor: UIColor = UIColor.whiteColor()
    var _leftTintColor: UIColor = UIColor.clearColor()
    var _rightTintColor: UIColor = UIColor.clearColor()
    var _startOffsetPercent:CGFloat = 0
    
    var barLayer:CAShapeLayer?
    var primaryMaskLayer:CAShapeLayer?
    var secondaryMaskLayer:CAShapeLayer?
    var leftTintLayer:CAShapeLayer?
    var rightTintLayer:CAShapeLayer?
    
    @IBInspectable var primaryImage: UIImage {
        get {
            return _primaryImage!;
        }
        set (newImage) {
            _primaryImage = newImage
            _primaryImageView?.image = _primaryImage
        }
    }
    
    @IBInspectable var secondaryImage: UIImage {
        get {
            return _secondaryImage!;
        }
        set (newImage){
            _secondaryImage = newImage
            _secondaryImageView?.image = _secondaryImage
        }
    }
    
    @IBInspectable var barColor:UIColor {
        get {
            return _barColor
        }
        set (newColor){
            _barColor = newColor
            barLayer?.fillColor = _barColor.CGColor
        }
    }
    
    @IBInspectable var startOffsetPercent:CGFloat = 0
    @IBInspectable var leftDefaultPosition:CGFloat = 0.2
    @IBInspectable var rightDefaultPosition:CGFloat = 0.8
    
    @IBInspectable var leftTintColor:UIColor {
        get {
            return _leftTintColor;
        }
        set (newColor){
            _leftTintColor = newColor
            leftTintLayer?.backgroundColor = newColor.CGColor
        }
    }
    
    @IBInspectable var rightTintColor:UIColor{
        get {
            return _rightTintColor;
        }
        set (newColor){
            _rightTintColor = newColor
            rightTintLayer?.backgroundColor = newColor.CGColor
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // IBInspectable Defaults
        _barColor = UIColor.whiteColor()
        _leftTintColor = UIColor.clearColor()
        _rightTintColor = UIColor.clearColor()
        
        // Create Image View
        
        _primaryImageView = UIImageView()
        _secondaryImageView = UIImageView()

        _primaryImageView?.translatesAutoresizingMaskIntoConstraints = false
        _secondaryImageView?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_primaryImageView!)
        addSubview(_secondaryImageView!)
        
        _primaryImageView?.contentMode = self.contentMode
        _secondaryImageView?.contentMode = self.contentMode
        
        _primaryImageView?.layer.masksToBounds = true
        _secondaryImageView?.layer.masksToBounds = true
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[v]|", options: .AlignAllTop, metrics: nil, views: ["v": _primaryImageView!]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[v]|", options: .AlignAllLeft, metrics: nil, views: ["v": _primaryImageView!]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[v]|", options: .AlignAllTop, metrics: nil, views: ["v": _secondaryImageView!]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[v]|", options: .AlignAllLeft, metrics: nil, views: ["v": _secondaryImageView!]))

        
        self.backgroundColor = UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1)

        // Create Layers
        
        primaryMaskLayer = CAShapeLayer()
        primaryMaskLayer?.path = CGPathCreateWithRect(_primaryImageView!.bounds, nil)
        primaryMaskLayer?.backgroundColor = UIColor.whiteColor().CGColor
        
        secondaryMaskLayer = CAShapeLayer()
        secondaryMaskLayer?.path = CGPathCreateWithRect(_secondaryImageView!.bounds, nil)
        secondaryMaskLayer?.backgroundColor = UIColor.whiteColor().CGColor
        
        _primaryImageView?.layer.mask = primaryMaskLayer
        _secondaryImageView?.layer.mask = secondaryMaskLayer
        
        leftTintLayer = CAShapeLayer()
        leftTintLayer?.path = CGPathCreateWithRect(_primaryImageView!.bounds, nil)
        leftTintLayer?.backgroundColor = leftTintColor.CGColor

        self.layer.addSublayer(leftTintLayer!)
        
        rightTintLayer = CAShapeLayer()
        rightTintLayer?.path = CGPathCreateWithRect(_secondaryImageView!.bounds, nil)
        rightTintLayer?.backgroundColor = leftTintColor.CGColor

        self.layer.addSublayer(rightTintLayer!)
        
        barLayer = CAShapeLayer()
        barLayer?.path = CGPathCreateWithRect(CGRect(x: 0, y: 0, width: 5, height: self.frame.size.height), nil)
        barLayer?.fillColor = _barColor.CGColor
        barLayer?.masksToBounds = true

        self.layer.addSublayer(barLayer!)
        
        // Create Gesture Recognizer
        
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        self.addGestureRecognizer(pan)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _barColor = UIColor.whiteColor()
        _leftTintColor = UIColor.clearColor()
        _rightTintColor = UIColor.clearColor()
    }
    
    override func layoutSubviews() {
        print("layoutSubviews")
        
        primaryMaskLayer?.path = CGPathCreateWithRect(_primaryImageView!.bounds, nil)
        secondaryMaskLayer?.path = CGPathCreateWithRect(_secondaryImageView!.bounds, nil)
        barLayer?.path = CGPathCreateWithRect(CGRect(x: 0, y: 0, width: 5, height: self.frame.size.height), nil)
        
        leftTintLayer?.path = CGPathCreateWithRect(_primaryImageView!.bounds, nil)
        rightTintLayer?.path = CGPathCreateWithRect(_secondaryImageView!.bounds, nil)

        updateMaskOffset(startOffsetPercent * self.frame.size.width, animated: false)
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        //let translation = recognizer.translationInView(self)
        
        let location = recognizer.locationInView(self)
        self.updateMaskOffset(location.x, animated: false)
        
        if(recognizer.state == .Began){
            
        }else if(recognizer.state == .Changed){
            
        }else if(recognizer.state == .Ended){
            // animate offset to the right location
            if(location.x < self.frame.size.width / 2){
                updateMaskOffset(self.frame.size.width * leftDefaultPosition, animated: true)
            }else{
                updateMaskOffset(self.frame.size.width * rightDefaultPosition, animated: true)
            }
            
        }
        
    }
    
    func updateMaskOffset(offsetX: CGFloat, animated: Bool){
        
        CATransaction.begin()
        if(!animated){
            CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        }else{
            CATransaction.setAnimationDuration(0.3)
        }
        
        
        let leftFrame = CGRect(x: 0, y: 0, width: offsetX, height: self.frame.size.height)
        
        primaryMaskLayer?.frame = leftFrame
        leftTintLayer?.frame = leftFrame
        
        let rightFrame = CGRect(x: offsetX, y: 0, width: self.frame.width - offsetX, height: self.frame.size.height)
        
        secondaryMaskLayer?.frame = rightFrame
        rightTintLayer?.frame = rightFrame
        
        barLayer?.frame = CGRect(x: offsetX, y: 0, width: 5, height: self.frame.size.height)
        
        CATransaction.commit()
    }

}
