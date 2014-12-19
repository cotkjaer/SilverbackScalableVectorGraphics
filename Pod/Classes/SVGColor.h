//
//  SVGColor.h
//  Pods
//
//  Created by Christian Otkjær on 19/12/14.
//
//

@import Foundation;
@import UIKit;

@interface SVGColor : NSObject

@property (nonatomic, readonly) UIColor * UIColor;

+ (instancetype)colorFromText:(NSString *)text;

+ (SVGColor *)colorWithRGBValue:(NSUInteger)rgbValue;

@end
