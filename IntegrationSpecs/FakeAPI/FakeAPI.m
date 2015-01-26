//
//  FakeAPI.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 06-12-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "FakeAPI.h"

#import "GCDWebServer.h"
#import "GCDWebServerDataResponse.h"

@interface FakeAPI ()
@property (nonatomic, readwrite, strong) GCDWebServer *server;
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
    NSMutableDictionary* options = [NSMutableDictionary dictionary];
    [options setObject:@(self.port) forKey:GCDWebServerOption_Port];
    [options setObject:@(YES) forKey:GCDWebServerOption_BindToLocalhost];
    [self.server startWithOptions:options error:nil];
}

- (void)stop;
{
    [self.server stop];

}

- (GCDWebServer *)server;
{
    if (!_server)
    {
        _server = [[GCDWebServer alloc] init];

        NSString *directoryPath = [[NSBundle bundleForClass:self.class] pathForResource:@"Responses" ofType:nil];
        [_server addHandlerWithMatchBlock:^GCDWebServerRequest *(NSString *requestMethod, NSURL *requestURL, NSDictionary *requestHeaders, NSString *urlPath, NSDictionary *urlQuery) {
            if ([requestMethod isEqualToString:@"GET"]) {
                return [[GCDWebServerRequest alloc] initWithMethod:requestMethod url:requestURL headers:requestHeaders path:urlPath query:urlQuery];
            } else {
                return nil;
            }
        } processBlock:^GCDWebServerResponse *(GCDWebServerRequest *request) {
            NSString *dataPath = [[directoryPath stringByAppendingPathComponent:request.path] stringByAppendingPathExtension:@"json"];
            NSData *data = [NSData dataWithContentsOfFile:dataPath];
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            return [GCDWebServerDataResponse responseWithJSONObject:object];
        }];
    }

    return _server;
}

@end
