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

    beforeEach(^{
        _baseURL = [NSURL URLWithString:@"https://api.example.org"];
        _httpClient = [[APITestHTTPClient alloc] initWithBaseURL:_baseURL];
    });

    describe(@"initialization", ^{
        it(@"can be initialized with a baseURL", ^{
            _client = [APIClient clientWithBaseURL:_baseURL];
            expect(_client.httpClient.baseURL).to.equal(_baseURL);
        });

        it(@"has a httpClient with the configured baseURL", ^{
            _client = [APIClient clientWithBaseURL:_baseURL];
            expect(_client.httpClient.baseURL).to.equal(_baseURL);
        });

        it(@"can be initialized with a different httpClient", ^{
            _client = [[APIClient alloc] initWithHTTPClient:_httpClient];
            expect(_client.httpClient).to.equal(_httpClient);
            expect(_client.httpClient.baseURL).to.equal(_baseURL);
        });

        it(@"cannot be initialized without a httpClient", ^{
            expect(^{
                _client = [[APIClient alloc] initWithHTTPClient:nil];
            }).to.raise(NSInternalInconsistencyException);
        });
    });

    describe(@"findAll:", ^{
        beforeEach(^{
            _client = [[APIClient alloc] initWithHTTPClient:_httpClient];
        });

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
});

SpecEnd