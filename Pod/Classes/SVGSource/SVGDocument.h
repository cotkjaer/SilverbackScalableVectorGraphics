//
//  SVGDocument.h
//  Pods
//
//  Created by Christian Otkjær on 17/12/14.
//
//

@import Foundation;

@class SVGSVGElement;

@interface SVGDocument : NSObject

@property (nonatomic, strong) SVGSVGElement * svgElement;

+ (instancetype)svgNamed:(NSString *)name;

@property (nonatomic, readonly) NSError * error;

@end
