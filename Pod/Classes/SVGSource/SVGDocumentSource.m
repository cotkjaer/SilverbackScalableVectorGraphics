//
//  SVGLocalFileSource.m
//  Pods
//
//  Created by Christian Otkjær on 17/12/14.
//
//

#import "SVGDocumentSource.h"

@interface SVGDocumentSource ()

@property (nonatomic, strong) NSInputStream* stream;

@property (nonatomic, strong) NSData * data;
@property (nonatomic, strong) NSString * fileName;
@property (nonatomic, strong) NSURL * fileURL;

@end

@implementation SVGDocumentSource

- (instancetype)initWithStream:(NSInputStream *)stream
{
    self = [super init];
    
    if (self)
    {
        _stream = stream;
    }
    
    return self;
}

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    
    if (self)
    {
        _data = data;
    }
    
    return self;
}

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    
    if (self)
    {
        _data = [text dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    return self;
}

- (instancetype)initWithUrl:(NSURL *)fileURL
{
    self = [super init];
    
    if (self)
    {
        _fileURL = fileURL;
    }
    
    return self;
}

- (instancetype)initWithFileNamed:(NSString *)fileName
{
    self = [super init];
    
    if (self)
    {
        _fileName = fileName;
    }
        
    return self;
}

- (NSURL *)fileURL
{
    if (_fileURL == nil)
    {
        if (self.fileName.length > 0)
        {
            _fileURL = [[NSBundle mainBundle] URLForResource:self.fileName withExtension:@"svg"];
        }
    }
    
    return _fileURL;
}

- (NSData *)data
{
    if (_data == nil)
    {
        if (self.fileURL)
        {
            _data = [NSData dataWithContentsOfURL:self.fileURL];
        }
    }
    return _data;
}

- (NSInputStream *)stream
{
    if (_stream == nil)
    {
        if (self.data)
        {
            _stream = [NSInputStream inputStreamWithData:self.data];
        }
    }
    
    return _stream;
}


@end
