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
    self = [super initWithValue:valueInSpecifiedUnits];
    
    if (self)
    {
        _unitType = unitType;
    }
    
    return self;
}

- (SVGFloat)valueInSpecifiedUnits:(SVGLengthUnitType)unitType
{
    // TODO: calculate
    return self.value;
}


@end
