//
//  APIClientSpecs.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright 2013 Klaas Pieter Annema. All rights reserved.
//

#import "SpecHelper.h"

#import "APIClient.h"

#import "APITestHTTPClient.h"
#import "Product.h"

SpecBegin(APIClient)

describe(@"APIClient", ^{
    before(^{
        setAsyncSpecTimeout(1.0);
    });

    __block APIClient *_client;
    __block NSURL *_baseURL;
    __block APITestHTTPClient *_httpClient;
    __block id _router;
    __block id _serializer;
    __block id _mapper;

    beforeEach(^{
        _baseURL = [NSURL URLWithString:@"https://api.example.org"];
        _httpClient = [[APITestHTTPClient alloc] initWithBaseURL:_baseURL];
        _router = [[APIRouter alloc] init];
        _serializer = [[APIJSONSerializer alloc] init];
        _mapper = [[APIMapper alloc] init];
        _client = [APIClient clientWithConfigurationBlock:^(APIClientConfiguration *configuration) {
            configuration.httpClient = _httpClient;
            configuration.router = _router;
            configuration.serializer = _serializer;
            configuration.mapper = _mapper;
        }];
    });

    describe(@"initialization", ^{
        it(@"creates a APIClient with the given properties", ^{
            _client = [APIClient clientWithConfigurationBlock:^(APIClientConfiguration *configuration) {
                configuration.httpClient = _httpClient;
                configuration.router = _router;
                configuration.serializer = _serializer;
                configuration.mapper = _mapper;
            }];
            expect(_client.httpClient).to.equal(_httpClient);
            expect(_client.router).to.equal(_router);
            expect(_client.serializer).to.equal(_serializer);
            expect(_client.mapper).to.equal(_mapper);
        });
    });

    describe(@"routing", ^{
        it(@"uses the router to build paths for a resource", ^{
            _router = OCMProtocolMock(@protocol(APIRouter));
            OCMStub([_router pathForAction:@"index" onResource:[Product class]]).andReturn(@"/objects");

            _client = [APIClient clientWithConfigurationBlock:^(APIClientConfiguration *configuration) {
                configuration.httpClient = _httpClient;
                configuration.router = _router;
                configuration.serializer = _serializer;
                configuration.mapper = _mapper;
            }];

            [_client findAll:[Product class]];
            expect(_httpClient.requests[0]).to.equal(@"/objects");
            [_router verify];
        });
    });

    describe(@"serialization", ^{
        it(@"uses the serializer to deserialize the response body", ^{
            _serializer = OCMProtocolMock(@protocol(APIJSONSerializer));
            OCMStub([_serializer deserializeJSON:[@"{}" dataUsingEncoding:NSUTF8StringEncoding]
                                           error:(NSError *__autoreleasing *)[OCMArg anyPointer]]).andReturn(@{});
            _client = [APIClient clientWithConfigurationBlock:^(APIClientConfiguration *configuration) {
                configuration.httpClient = _httpClient;
                configuration.router = _router;
                configuration.serializer = _serializer;
                configuration.mapper = _mapper;
            }];

            [_client findAll:[Product class]];
            [_httpClient succeedRequests];
            [_serializer verify];
        });
    });

    describe(@"mapping", ^{
        it(@"uses the mapper to map the response to resource objects", ^{
            _mapper = OCMProtocolMock(@protocol(APIMapper));

            _client = [APIClient clientWithConfigurationBlock:^(APIClientConfiguration *configuration) {
                configuration.httpClient = _httpClient;
                configuration.router = _router;
                configuration.serializer = _serializer;
                configuration.mapper = _mapper;
            }];

            [_client findAll:[Product class]];
            [_httpClient succeedRequests];
            OCMVerify([_mapper mapValues:@{} toResource:[Product class]]);
        });
    });

    describe(@"findAll:", ^{
        it(@"returns a response promise", ^{
            id response = [_client findAll:[Product class]];
            expect(response).to.beKindOf([APIResponse class]);
        });

        it(@"makes a request for the resource", ^{
            [_client findAll:[Product class]];
            expect(_httpClient.requests[0]).to.equal(@"products");
        });

        it(@"uses the router to build paths for the index action", ^{
            _router = OCMProtocolMock(@protocol(APIRouter));
            OCMStub([_router pathForAction:@"index" onResource:[Product class]]).andReturn(@"/objects");

            _client = [APIClient clientWithConfigurationBlock:^(APIClientConfiguration *configuration) {
                configuration.httpClient = _httpClient;
                configuration.router = _router;
                configuration.serializer = _serializer;
                configuration.mapper = _mapper;
            }];

            [_client findAll:[Product class]];
            expect(_httpClient.requests[0]).to.equal(@"/objects");
            [_router verify];
        });

        context(@"with a successful request", ^{
            it(@"resolves the response with the mapping result", ^AsyncBlock {
                APIResponse *response = [_client findAll:[Product class]];
                response.success = ^(id products) {
                    expect(products).to.beKindOf([NSArray class]);
                    expect(products[0]).to.beInstanceOf([Product class]);
                    done();
                };
                [_httpClient succeedRequestsWithJSONObject:@{@"products": @[@{@"name": @"Karma"}]}];
            });
        });

        context(@"with a failed request", ^{
            it(@"rejects the response with the error", ^AsyncBlock {
                APIResponse *response = [_client findAll:[Product class]];
                response.failure = ^(NSError *error) {
                    expect(error).notTo.beNil();
                    done();
                };
                [_httpClient failRequests];
            });

            it(@"rejects the response promise when serialization fails", ^AsyncBlock{
                APIResponse *response = [_client findAll:[Product class]];
                response.failure = ^(NSError *error) {
                    expect(error.domain).to.equal(APIJSONSerializerErrorDomain);
                    done();
                };
                [_httpClient succeedRequestsWithResponseString:@"<html></html>"];
            });
        });
    });

    describe(@"findResource:withID", ^{
        it(@"returns a response promise", ^{
            id response = [_client findResource:[Product class] withID:@1];
            expect(response).to.beKindOf([APIResponse class]);
        });

        it(@"makes a request for the resource", ^{
            [_client findResource:[Product class] withID:@1];
            expect(_httpClient.requests[0]).to.equal(@"products/1");
        });

        it(@"uses the router to build paths for the show action", ^{
            _router = OCMProtocolMock(@protocol(APIRouter));
            OCMStub([_router pathForAction:@"show" onResource:[Product class] withArguments:@{@"id": @1}]).andReturn(@"/objects/1");

            _client = [APIClient clientWithConfigurationBlock:^(APIClientConfiguration *configuration) {
                configuration.httpClient = _httpClient;
                configuration.router = _router;
                configuration.serializer = _serializer;
                configuration.mapper = _mapper;
            }];
            
            [_client findResource:[Product class] withID:@1];
            expect(_httpClient.requests[0]).to.equal(@"/objects/1");
            [_router verify];
        });

        context(@"with a successful request", ^{
            it(@"resolves the response with the mapping result", ^AsyncBlock {
                APIResponse *response = [_client findResource:[Product class] withID:@1];
                response.success = ^(Product *product) {
                    expect(product).to.beKindOf([Product class]);
                    done();
                };
                [_httpClient succeedRequestsWithJSONObject:@{@"products": @[@{@"name": @"Karma"}]}];
            });
        });

        context(@"with a failed request", ^{
            it(@"rejects the response with the error", ^AsyncBlock {
                APIResponse *response = [_client findResource:[Product class] withID:@1];
                response.failure = ^(NSError *error) {
                    expect(error).notTo.beNil();
                    done();
                };
                [_httpClient failRequests];
            });


            it(@"rejects the response promise when serialization fails", ^AsyncBlock{
                APIResponse *response = [_client findResource:[Product class] withID:@1];
                response.failure = ^(NSError *error) {
                    expect(error.domain).to.equal(APIJSONSerializerErrorDomain);
                    done();
                };
                [_httpClient succeedRequestsWithResponseString:@"<html></html>"];
            });
        });
    });
});

SpecEnd