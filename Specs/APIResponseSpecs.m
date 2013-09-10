//
//  APIResponseSpecs.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 10-09-13.
//  Copyright 2013 Klaas Pieter Annema. All rights reserved.
//

#import "SpecHelper.h"

#import "APIResponse.h"

SpecBegin(APIResponse)

describe(@"APIResponse", ^{
    it(@"can be resolved", ^{
        APIResponse *response = [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
            resolve(nil);
        }];
        expect(response.isSuccess).to.beTruthy();
    });

    it(@"can be rejected", ^{
        APIResponse *response = [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
            reject(nil);
        }];
        expect(response.isFailure).to.beTruthy();
    });
});

SpecEnd