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

APIResponse *delayedResponse(id object)
{
    return [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
           resolve(object);
        });
    }];
}

SpecBegin(APIResponse)

__block id _object;

describe(@"APIResponse", ^{
    beforeEach(^{
        _object = [[NSObject alloc] init];
    });

    it(@"can be resolved", ^{
        APIResponse *response = resolvedResponse(_object);
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
            APIResponse *response = resolvedResponse(_object);
            expect(response.object).to.equal(_object);
        });

        it(@"calls the success block when set on an already resolved response", ^{
            APIResponse *response = resolvedResponse(_object);
            response.success = ^(id object) {
                expect(object).to.equal(_object);
            };
        });

        it(@"calls the success block when the response is resolved", ^AsyncBlock{
            APIResponse *response = delayedResponse(_object);
            response.success = ^(id object) {
                expect(object).to.equal(_object);
                done();
            };
        });
    });
});

SpecEnd