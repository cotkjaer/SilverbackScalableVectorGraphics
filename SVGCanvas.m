//
//  SVGCanvas.m
//  Pods
//
//  Created by Christian Otkjær on 19/12/14.
//
//

#import "SVGCanvas.h"
#import "SVGCoordinateSystem.h"
#import "SVGSVGElement.h"

@interface SVGCanvas ()

@end

@implementation SVGCanvas


- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _coordinateSystem = [SVGCoordinateSystem new];
    }
    
    return self;
}

@end
