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

    beforeEach(^{
        _baseURL = [NSURL URLWithString:@"https://api.example.org"];
        _httpClient = [[APITestHTTPClient alloc] initWithBaseURL:_baseURL];
        _router = [[APIRouter alloc] init];
        _client = [[APIClient alloc] initWithHTTPClient:_httpClient router:_router];
    });

    describe(@"initialization", ^{
        it(@"creates a configuration with the given httpClient", ^{
            _client = [[APIClient alloc] initWithHTTPClient:_httpClient router:_router];
            expect(_client.configuration.httpClient).to.equal(_httpClient);
        });

        it(@"creates a configuration with the given router", ^{
            _client = [[APIClient alloc] initWithHTTPClient:_httpClient router:_router];
            expect(_client.configuration.router).to.equal(_router);
        });
    });

    describe(@"findAll:", ^{
        it(@"returns a response promise", ^{
            id response = [_client findAll:[Product class]];
            expect(response).to.beKindOf([APIResponse class]);
        });

        it(@"makes a request for the resource", ^{
            [_client findAll:[Product class]];
            expect(_httpClient.requests[0]).to.equal(@"/products");
        });

        context(@"with a successful request", ^{
            it(@"resolves the response with the response body", ^AsyncBlock {
                APIResponse *response = [_client findAll:[Product class]];
                response.success = ^(id object) {
                    expect(object).notTo.beNil();
                    done();
                };
                [_httpClient succeedRequests];
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
        });
    });

    describe(@"routing", ^{
        it(@"uses the router to build paths for a resource", ^{
            _router = [OCMockObject mockForProtocol:@protocol(APIRouter)];
            [[[_router expect] andReturn:@"/objects"] pathForAction:@"index" onResource:[Product class]];
            _client = [[APIClient alloc] initWithHTTPClient:_httpClient router:_router];
            [_client findAll:[Product class]];
            expect(_httpClient.requests[0]).to.equal(@"/objects");
            [_router verify];
        });
    });
});

SpecEnd