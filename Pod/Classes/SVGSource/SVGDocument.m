//
//  SVGDocument.m
//  Pods
//
//  Created by Christian Otkjær on 17/12/14.
//
//

#import "SVGDocument.h"
#import "SVGDocumentSource.h"
#import "SVGParser.h"
#import "SVGSVGElement.h"

@interface SVGDocument () <SVGParserDelegate>

@property (nonatomic, readonly, strong) SVGDocumentSource * documentSource;

@property (nonatomic, readonly, strong) SVGParser * parser;

@property (nonatomic, strong) NSError * error;

@property (nonatomic) BOOL parsingDidFinish;
@property (nonatomic) BOOL parsingDidBegin;

- (instancetype)initWithDocumentSource:(SVGDocumentSource *)documentSource;

@end

@implementation SVGDocument

- (instancetype)initWithDocumentSource:(SVGDocumentSource *)documentSource
{
    [UIImage imageNamed:@""];
    self = [super init];
    
    if (self)
    {
        _documentSource = documentSource;
        _parser = [SVGParser new];
        _parser.delegate = self;
    }
    
    return self;
}

+ (instancetype)svgNamed:(NSString *)name
{
    SVGDocumentSource * source = [[SVGDocumentSource alloc] initWithFileNamed:name];
    
    return [[SVGDocument alloc] initWithDocumentSource:source];
}

- (SVGSVGElement *)svgElement
{
    if (_svgElement == nil && !self.parsingDidBegin)
    {
        self.parsingDidBegin = YES;
        [self.parser parseDocumentSource:self.documentSource];
    }
    
    return _svgElement;
}

#pragma mark - <SVGParserDelegate>

- (void)parser:(SVGParser *)parser didProduceTopLevelElement:(SVGElement *)element
{
    if ([element isKindOfClass:[SVGSVGElement class]])
    {
        self.svgElement = (SVGSVGElement *)element;
    }
}

- (void)parserDidBeginParsing:(SVGParser *)parser
{
    self.parsingDidBegin = YES;
}

- (void)parserDidFinishParsing:(SVGParser *)parser
{
    self.parsingDidFinish = YES;
}

- (void)parser:(SVGParser *)parser parseErrorOccurred:(NSError *)parseError
{
    self.error = parseError;
}

@end
