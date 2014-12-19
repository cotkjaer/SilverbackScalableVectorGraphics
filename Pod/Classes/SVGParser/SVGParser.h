//
//  SVGParser.h
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

@import Foundation;

@class SVGDocumentSource;
@class SVGElement;
@class SVGParser;

@protocol SVGParserDelegate <NSObject>

@optional

- (void)parserDidBeginParsing:(SVGParser *)parser;

- (void)parserDidFinishParsing:(SVGParser *)parser;

- (void)parser:(SVGParser *)parser parseErrorOccurred:(NSError *)parseError;

- (void)parser:(SVGParser *)parser didProduceTopLevelElement:(SVGElement *)element;

@end


@interface SVGParser : NSObject

- (void)parseDocumentSource:(SVGDocumentSource *)documentSource;

- (void)parseXmlStream:(NSInputStream *)xmlStream;

- (void)parseXmlString:(NSString *)xmlString;

@property (nonatomic, strong) NSArray * topLevelSvgElements;

@property (nonatomic, weak) id<SVGParserDelegate> delegate;

@end
