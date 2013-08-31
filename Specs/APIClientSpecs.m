//
//  APIClientSpecs.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright 2013 Klaas Pieter Annema. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import "APIClient.h"

SpecBegin(APIClient)

__block APIClient *_client;

describe(@"APIClient", ^{
    it(@"can be initialized with a baseURL", ^{
        NSURL *baseURL = [NSURL URLWithString:@"https://api.example.org"];
        _client = [[APIClient alloc] initWithBaseURL:baseURL];
        expect(_client.baseURL).to.equal(baseURL);

        _client = [APIClient clientWithBaseURL:baseURL];
        expect(_client.baseURL).to.equal(baseURL);
    });

    it(@"cannot be initialized without a baseURL", ^{
        expect(^{
            _client = [[APIClient alloc] init];
        }).to.raise(NSInternalInconsistencyException);
    });
});

SpecEnd