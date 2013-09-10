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

__block APIClient *_client;

describe(@"APIClient", ^{
    before(^{
        setAsyncSpecTimeout(0.0);
    });

    __block NSURL *_baseURL;

    beforeEach(^{
        _baseURL = [NSURL URLWithString:@"https://api.example.org"];
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
            APITestHTTPClient *httpClient = [[APITestHTTPClient alloc] initWithBaseURL:_baseURL];
            _client = [[APIClient alloc] initWithHTTPClient:httpClient];
            expect(_client.httpClient).to.equal(httpClient);
            expect(_client.httpClient.baseURL).to.equal(_baseURL);
        });

        it(@"cannot be initialized without a httpClient", ^{
            expect(^{
                _client = [[APIClient alloc] initWithHTTPClient:nil];
            }).to.raise(NSInternalInconsistencyException);
        });
    });

    describe(@"finding", ^{
        it(@"can find all resources of a type", ^AsyncBlock {
            APIResponse *response = [_client findAll:[Product class]];
            response.success = ^(NSArray *products) {
                expect(products).notTo.beNil();
                done();
            };
        });
    });

    describe(@"findAll:", ^{
        it(@"returns a response promise", ^{
            id response = [_client findAll:[Product class]];
            expect(response).to.beKindOf([APIResponse class]);
        });
    });
});

SpecEnd