//
//  TestSVGPathParser.m
//  SilverbackScalableVectorGraphics
//
//  Created by Christian Otkjær on 17/12/14.
//  Copyright (c) 2014 christian otkjær. All rights reserved.
//

#import <SilverbackScalableVectorGraphics/SVGPathParser.h>
#import <SilverbackScalableVectorGraphics/SVGPathElement.h>

SpecBegin(SVGPathParser)

describe(@"SVGPathParser", ^{
    
    __block SVGPathParser * parser = [SVGPathParser new];
    
    beforeAll(^{
    
        parser = [SVGPathParser new];
        
    });
/*
    it(@"can parse 'M 0 0'", ^{
        
        pathElement = [[SVGMutablePathElement alloc] initWithParent:nil andAttributes:@{@"d" : @"M 0 0"}];
        
        BOOL didParse = [parser parsePathSegmenetsIn:pathElement];
        
        expect(didParse).beTruthy;
        
        expect(pathElement.pathSegments).haveCountOf(1);
    });
    */
    
    NSDictionary * segmentsByPathStrings = @{@"M 0.0 200" : @1,
                                             @"M 0, 0 Z" : @2,
                                             @"m 11 12 21 22" : @1,
                                             @"M 0 0 h 100" : @2,
                                             @"M 0 0 a 55 55 -45 , 1 0 34.1 45.231" : @2,
                                    @"M364.467,437.706c0,0,79.639,347.869,260.49,222.337 c57.758-40.091-120.211-159.571,2.781-137.129c126.695,23.118-254.214-188.958,5.73-144.788 c381.914,64.896-337.234-111.7-70.213-125.53s173.404-63.83,36.17-63.83C462.192,188.766,248.51-260.167,364.467,437.706z" : @7
                                             };
    
    [segmentsByPathStrings enumerateKeysAndObjectsUsingBlock:^(NSString * pathString, NSNumber * expectedElementCount, BOOL *stop)
    {
        SVGMutablePathElement * pathElement = [[SVGMutablePathElement alloc] initWithParent:nil andAttributes:@{@"d" : pathString}];

        BOOL didParse = [parser parsePathSegmenetsIn:pathElement];

        it(pathString, ^{
            
            expect(didParse).beTruthy;
            
            expect(pathElement.pathSegments).haveCountOf(expectedElementCount.unsignedIntegerValue);
        });
    }];
    
    
    it(@"can read", ^{
        expect(@"team").toNot.contain(@"I");
    });
    
    it(@"will wait and succeed", ^AsyncBlock {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            done();
        });
    });
});

SpecEnd