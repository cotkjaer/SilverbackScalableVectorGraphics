//
//  SVGElement.h
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

@import Foundation;

@class SVGContainerElement;
@class SVGCoordinateSystem;

@interface SVGElement : NSObject

+ (SVGElement *)svgElementForElementName:(NSString *)elementName
                                  parent:(SVGContainerElement *)parent
                              attributes:(NSDictionary *)attributes;


- (instancetype)initWithParent:(SVGContainerElement *)parentElement
                 andAttributes:(NSDictionary *)attributes;

//@property (nonatomic, strong) NSString * elementID;

@property (nonatomic, readonly) NSString * name;

@property (nonatomic, readonly) NSDictionary * attributes;

@property (nonatomic, readonly) SVGContainerElement *parent;

@property (nonatomic, readonly) SVGCoordinateSystem * coordinateSystem;

#pragma mark - Rendering

- (void)render;

@end

#import "SVGLength.h"
#import "SVGAngle.h"
#import "SVGCoordinate.h"

//#import "SVGPaint.h"
//#import "SVGColor.h"

CGRect CGRectMakeAtCenter(CGFloat cx, CGFloat cy, CGFloat width, CGFloat height);

CGRect CGRectMakeSquare(CGFloat ox, CGFloat oy, CGFloat side);
