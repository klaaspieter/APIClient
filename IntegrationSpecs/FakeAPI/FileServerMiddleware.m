//
//  FileServerMiddleware.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 09-12-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "FileServerMiddleware.h"

@interface FileServerMiddleware ()
@property (nonatomic, readwrite, strong) NSURL *directoryURL;
@property (nonatomic, readwrite, strong ) NSString *basePath;
@end

@implementation FileServerMiddleware

+ (instancetype)fileServerMiddleWithDirectoryURL:(NSURL *)directoryURL forURLBasePath:(NSString *)basePath;
{
	return [[self alloc] initWithDirectoryURL:directoryURL forURLBasePath:basePath];
}

- (id)init;
{
    return [self initWithDirectoryURL:nil forURLBasePath:nil];
}

- (id)initWithDirectoryURL:(NSURL *)directoryURL forURLBasePath:(NSString *)basePath;
{
    NSParameterAssert(directoryURL);
    NSParameterAssert(basePath);

    self = [super init];

    if (self) {
        _directoryURL = directoryURL;
        _basePath = basePath;
    }

    return self;
}


-(void)didReceiveRequest:(BARRequest *)request
		   forConnection:(BARConnection *)connection
		 continueHandler:(void (^)(void))handler;
{
    NSString *relativePath = request.URL.relativePath;
    NSURL *fileURL = [self.directoryURL URLByAppendingPathComponent:relativePath];

    NSString *extension = @"json";
    fileURL = [fileURL URLByAppendingPathExtension:extension];

    BARResponse *response = [[BARResponse alloc] init];
    response.statusCode = 200;
    response.responseData = [[NSFileManager defaultManager] contentsAtPath:fileURL.path];
    [response setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [connection sendResponse:response];
}

@end
