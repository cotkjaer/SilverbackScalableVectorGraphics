//
//  SVGPathAndPointParser.h
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import <Foundation/Foundation.h>

@class SVGMutablePathElement;

@interface SVGPathAndPointParser : NSObject

- (BOOL)parsePathSegmenetsIn:(SVGMutablePathElement *)path;

//- (BOOL)readCommands:(NSScanner*)scanner
//            intoPath:(SVGMutablePathElement *)path;

@end
