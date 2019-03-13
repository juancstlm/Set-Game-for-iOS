//
//  ShapeView.swift
//  Set
//
//  Created by Juan Castillo on 3/13/19.
//  Copyright © 2019 Juan Castillo. All rights reserved.
//

import UIKit

enum Orientation {
    case horizontal
    case vertical
}

class ShapeView: UIView {

    private struct sizes {
        static let strokePercent = 0.03
        static let numStripes = 11
        static let symbolAspectRatio = 1.55
    }
    
    @IBInspectable
    var isSelected: Bool = false
    var orientation: Orientation = Orientation.vertical {didSet {setNeedsDisplay(); setNeedsLayout()}}
    var shape: Card.Shape = Card.Shape.oval {didSet {setNeedsDisplay(); setNeedsLayout()}}
    var color: UIColor = UIColor.green {didSet {setNeedsDisplay(); setNeedsLayout()}}
    var number: Card.Number = Card.Number.one {didSet {setNeedsDisplay(); setNeedsLayout()}}
    var fill: Card.Fill = Card.Fill.open {didSet {setNeedsDisplay(); setNeedsLayout()}}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func draw(_ rect: CGRect) {
        
        let width = min(bounds.width, bounds.height / CGFloat(sizes.symbolAspectRatio))
        let height = width * CGFloat(sizes.symbolAspectRatio)
        
        let stroke = height * CGFloat(sizes.strokePercent)
        let offset = height/28
        let path: UIBezierPath
        
        
        /// SWITCH CASE FOR SHAPES
        /// Shout out to andriustheviking
        switch shape {
        case .oval:
            let shapeRect = CGRect(origin: CGPoint(x: offset , y: offset),
                                   size: CGSize(width: width - 2*offset,
                                                height: height - 2*offset ) )
            path = UIBezierPath(roundedRect: shapeRect, cornerRadius: shapeRect.width )
        case .squiggle:
            //add curves to form squiggle shape
            path = UIBezierPath()
            let startPoint = CGPoint(x: 3 * width / 8, y: offset)
            
            path.move(to: startPoint )
            path.addCurve(to: CGPoint(x: width / 4, y: height / 6),
                          controlPoint1: CGPoint(x: 3 * width / 8, y: offset),
                          controlPoint2: CGPoint( x: 1 * width / 8, y: 1 * height / 18))
            path.addCurve(to: CGPoint(x: 5 * width / 32, y: 13 * height / 16),
                          controlPoint1: CGPoint(x: 9 * width / 16, y: 8 * height / 16),
                          controlPoint2: CGPoint(x: 3 * -width / 32, y: 7 * height / 16))
            path.addCurve(to: CGPoint(x: 5 * width / 8, y: height - offset),
                          controlPoint1: CGPoint(x: 5 * width / 16, y: 16 * height / 16),
                          controlPoint2: CGPoint(x: 10 * width / 16, y: height - offset))
            
            //append path with mirrored duplicate
            let duplicatePath = UIBezierPath()
            
            duplicatePath.append(path)
            duplicatePath.apply(CGAffineTransform(scaleX: -1, y: -1))
            
            duplicatePath.apply(CGAffineTransform(translationX: rect.origin.x + path.bounds.maxX + startPoint.x , y: rect.origin.y + path.bounds.maxY + startPoint.y * 0.93))
            
            
            path.append(duplicatePath)
        case .diamond:
            path = UIBezierPath()
            path.move(to: CGPoint(x: width / 2, y: offset))
            path.addLine(to: CGPoint(x: offset, y: height / 2.0 ) )
            path.addLine(to: CGPoint(x: width / 2, y: height - offset ) )
            path.addLine(to: CGPoint(x: width - offset, y: height / 2.0 ) )
            path.close()
        }
        
        switch orientation {
            
        case .vertical:             //center in view
            path.apply(CGAffineTransform(translationX: (bounds.maxX - width) / 2.0, y: (bounds.maxY - height) / 2.0 ))
        case .horizontal:           //rotate and center in view
            let scale =  min(bounds.width / height, CGFloat(sizes.symbolAspectRatio))
            path.apply(CGAffineTransform(a: 0, b: scale, c: -scale, d: 0, tx: (scale * height + bounds.maxX) / 2.0, ty: ( bounds.maxY - scale * width) / 2.0 ))
        }
        
        switch fill {
        case .open:
            color.setStroke()
            path.lineWidth = stroke
            path.stroke()
        case .solid:
            color.setFill()
            path.fill()
        case .stripped:
            color.setStroke()
            
            path.lineWidth = stroke
            path.stroke()
            let clipPath = UIBezierPath()
            clipPath.append(path)
            clipPath.addClip()
            
            // draw the stripes
            let stripes = UIBezierPath()
            var linePoint = CGPoint(x: -offset, y: bounds.height / CGFloat(2 * sizes.numStripes))
            stripes.move(to: linePoint)
            for _ in 1 ... 2*sizes.numStripes {
                linePoint.x = bounds.width + offset
                stripes.addLine(to: linePoint)
                linePoint.y += height / CGFloat(sizes.numStripes)
                stripes.addLine(to: linePoint)
                linePoint.x = -offset
                stripes.addLine(to: linePoint)
                linePoint.y += height / CGFloat(sizes.numStripes)
                stripes.addLine(to: linePoint)
            }
            stripes.lineWidth = stroke
            stripes.stroke()
        }
    }
    
}
