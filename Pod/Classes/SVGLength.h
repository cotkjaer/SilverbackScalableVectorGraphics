//
//  SVGLength.h
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGValue.h"

typedef NS_ENUM(NSUInteger, SVGLengthUnitType)
{
    SVGLengthUnitTypeUnknown = 0,
    SVGLengthUnitTypeNumber = 1,
    SVGLengthUnitTypePERCENTAGE = 2,
    SVGLengthUnitTypeEMS = 3,
    SVGLengthUnitTypeEXS = 4,
    SVGLengthUnitTypePX = 5,
    SVGLengthUnitTypeCM = 6,
    SVGLengthUnitTypeMM = 7,
    SVGLengthUnitTypeIN = 8,
    SVGLengthUnitTypePT = 9,
    SVGLengthUnitTypePC = 10,
};

@interface SVGLength : SVGValue

@property (nonatomic, readonly) SVGLengthUnitType unitType;

@property (nonatomic, readonly) SVGFloat value;
@property (nonatomic, readonly) SVGFloat valueInSpecifiedUnits;
@property (nonatomic, readonly) NSString * valueAsString;

- (instancetype)initWithWithUnitType:(SVGLengthUnitType)unitType
               valueInSpecifiedUnits:(SVGFloat)valueInSpecifiedUnits;

- (SVGFloat)valueInSpecifiedUnits:(SVGLengthUnitType)unitType;

@end
