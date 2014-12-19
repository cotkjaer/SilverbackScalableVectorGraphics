//
//  SVGScaleTransformation.m
//  Pods
//
//  Created by Christian Otkjær on 19/12/14.
//
//

#import "SVGScaleTransformation.h"

@implementation SVGScaleTransformation

- (instancetype)initWithScaleFactor:(SVGFloat)scaleFactor
{
    self = [super init];
    
    if (self)
    {
        _scaleFactor = scaleFactor;
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithScaleFactor:1.f];
}

- (SVGLength *)transformLength:(SVGLength *)length
{
    return [[SVGLength alloc] initWithWithUnitType:length.unitType valueInSpecifiedUnits:(length.value * self.scaleFactor)];
}

- (SVGCoordinate *)transformCoordinate:(SVGCoordinate *)coordinate
{
    return [[SVGCoordinate alloc] initWithValue:(coordinate.value * self.scaleFactor)];
}

@end
