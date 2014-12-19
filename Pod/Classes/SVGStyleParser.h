//
//  SVGStyleParser.h
//  Pods
//
//  Created by Christian Otkjær on 19/12/14.
//
//

#import <Foundation/Foundation.h>

@interface SVGStyleParser : NSObject

+ (NSDictionary *)attributesFromStyleText:(NSString *)styleText;

@end
