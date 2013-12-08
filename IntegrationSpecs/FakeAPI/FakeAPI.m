//
//  FakeAPI.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 06-12-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "FakeAPI.h"

#import "Barista.h"
#import "BARStaticFileServer.h"
#import "BARRouter.h"

@interface FakeAPI ()
@property (nonatomic, readwrite, strong) BARServer *server;
@property (nonatomic, readwrite, assign) NSUInteger port;
@end

@implementation FakeAPI

- (id)init;
{
    return [self initWithPort:0];
}

- (id)initWithPort:(NSUInteger)port;
{
    NSParameterAssert(port);
    self = [super init];
    if (self) {
        _port = port;
    }

    return self;
}

- (void)start;
{
    [self.server startListening];
}

- (void)stop;
{
    [self.server stopListening];
}

- (BARServer *)server;
{
    if (!_server)
    {
        _server = [BARServer serverWithPort:self.port];
        NSURL *directoryURL = [[NSBundle bundleForClass:self.class] bundleURL];
        [_server addGlobalMiddleware:[BARStaticFileServer fileServerWithDirectoryURL:directoryURL forURLBasePath:@"/"]];
    }



    return _server;
}

@end
