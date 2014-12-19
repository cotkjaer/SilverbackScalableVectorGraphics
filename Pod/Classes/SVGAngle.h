//
//  SVGAngle.h
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGValue.h"

typedef NS_ENUM(NSUInteger, SVGAngleUnitType)
{
    SVGAngleUnitTypeUnknown = 0,
    SVGAngleUnitTypeUnspecified = 1,
    SVGAngleUnitTypeDegrees = 2,
    SVGAngleUnitTypeRadians = 3,
    SVGAngleUnitTypeGrad = 4
};

@interface SVGAngle : NSObject

@property (nonatomic, readonly) SVGAngleUnitType unitType;

@property (nonatomic, readonly) SVGFloat value;
@property (nonatomic, readonly) SVGFloat valueInSpecifiedUnits;
@property (nonatomic, readonly) NSString * valueAsString;

- (instancetype)initWithWithUintType:(SVGAngleUnitType)unitType valueInSpecifiedUnits:(SVGFloat)valueInSpecifiedUnits;

- (SVGFloat)valueInSpecifiedUnits:(SVGAngleUnitType)unitType;

@end
