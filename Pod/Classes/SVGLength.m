//
//  SVGLength.m
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGLength.h"

@implementation SVGLength

- (instancetype)initWithWithUnitType:(SVGLengthUnitType)unitType valueInSpecifiedUnits:(SVGFloat)valueInSpecifiedUnits
{
    self = [super init];
    
    if (self)
    {
        _unitType = unitType;
        _valueInSpecifiedUnits = valueInSpecifiedUnits;
    }
    
    return self;
}

- (SVGFloat)valueInSpecifiedUnits:(SVGLengthUnitType)unitType
{
    // TODO: calculate
    return self.valueInSpecifiedUnits;
}


@end
