//
//  SVGElement.h
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

@import Foundation;

@class SVGContainerElement;

#import "SVGCoordinateSystem.h"

@interface SVGElement : NSObject

+ (SVGElement *)svgElementForElementName:(NSString *)elementName
                                  parent:(SVGContainerElement *)parent
                              attributes:(NSDictionary *)attributes;


- (instancetype)initWithParent:(SVGContainerElement *)parentElement
                 andAttributes:(NSDictionary *)attributes;

//@property (nonatomic, strong) NSString * elementID;

@property (nonatomic, readonly) NSString * name;

@property (nonatomic, readonly) NSDictionary * attributes;

@property (nonatomic, strong) SVGContainerElement *parent;

@property (nonatomic, readonly) SVGCoordinateSystem * coordinateSystem;

#pragma mark - Rendering

@property (nonatomic, readonly) SVGColor * strokeColor;
@property (nonatomic, readonly) SVGColor * fillColor;

- (void)render;

@end

