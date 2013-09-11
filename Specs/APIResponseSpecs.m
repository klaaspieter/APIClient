//
//  APIResponseSpecs.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 10-09-13.
//  Copyright 2013 Klaas Pieter Annema. All rights reserved.
//

#import "SpecHelper.h"

#import "APIResponse.h"

APIResponse *resolvedResponse(id object)
{
    return [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
        resolve(object);
    }];
};

SpecBegin(APIResponse)

describe(@"APIResponse", ^{
    it(@"can be resolved", ^{
        APIResponse *response = resolvedResponse(nil);
        expect(response.isSuccess).to.beTruthy();
    });

    it(@"can be rejected", ^{
        APIResponse *response = [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
            reject(nil);
        }];
        expect(response.isFailure).to.beTruthy();
    });

    describe(@"resolving", ^{
        it(@"sets the resolved object", ^{
            id object = [[NSObject alloc] init];
            APIResponse *response = resolvedResponse(object);
            expect(response.object).to.equal(object);
        });
    });
});

SpecEnd