//
//  SVGContainerElement.h
//  Pods
//
//  Created by Christian Otkjær on 17/12/14.
//
//

#import "SVGElement.h"

@interface SVGContainerElement : SVGElement

- (void)addElement:(SVGElement *)element;

- (void)addText:(NSString *)text;

@end
