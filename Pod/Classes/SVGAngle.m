//
//  SVGAngle.m
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGAngle.h"

@implementation SVGAngle

- (instancetype)initWithWithUintType:(SVGAngleUnitType)unitType valueInSpecifiedUnits:(SVGFloat)valueInSpecifiedUnits
{
    self = [super init];
    
    if (self)
    {
        _unitType = unitType;
        _valueInSpecifiedUnits = valueInSpecifiedUnits;
    }
    
    return self;
}

- (SVGFloat)valueInSpecifiedUnits:(SVGAngleUnitType)unitType
{
    // TODO: calculate
    return self.valueInSpecifiedUnits;
}

@end
