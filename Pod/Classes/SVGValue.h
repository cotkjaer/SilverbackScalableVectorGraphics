//
//  SVGValue.h
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

@import Foundation;

@import UIKit;

typedef float SVGFloat;

SVGFloat SVGFloatFromString(NSString * str);

struct SVGCoordinatePair
{
    SVGFloat x;
    SVGFloat y;
};

typedef struct SVGCoordinatePair SVGCoordinatePair;

SVGCoordinatePair SVGCoordinatePairMake(SVGFloat x, SVGFloat y);

@interface SVGValue : NSObject

@property (nonatomic, readonly) float value;

+ (instancetype)fromText:(NSString *)valueText;

@end
