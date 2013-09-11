//
//  APIResponseSpecs.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 10-09-13.
//  Copyright 2013 Klaas Pieter Annema. All rights reserved.
//

#import "SpecHelper.h"

#import "APIResponse.h"

APIResponse *resolvedResponse(id object);
APIResponse *delayedResolvedResponse(id object);
APIResponse *rejectedResponse(id error);
APIResponse *delayedRejectedResponse(id error);

SpecBegin(APIResponse)

__block id _object;

describe(@"APIResponse", ^{
    beforeEach(^{
        _object = [[NSObject alloc] init];
    });

    it(@"can be resolved", ^{
        APIResponse *response = resolvedResponse(nil);
        expect(response.isSuccess).to.beTruthy();
    });

    it(@"can be rejected", ^{
        APIResponse *response = rejectedResponse(nil);
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
            APIResponse *response = delayedResolvedResponse(_object);
            response.success = ^(id object) {
                expect(object).to.equal(_object);
                done();
            };
        });

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
        it(@"cannot be resolved again", ^{
            APIResponse *response = [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
                resolve(_object);
                expect(^{
                    resolve(nil);
                }).to.raise(NSInternalInconsistencyException);
            }];
        });

        it(@"cannot be rejected", ^{
            APIResponse *response = [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
                resolve(_object);
                expect(^{
                    reject(nil);
                }).to.raise(NSInternalInconsistencyException);
            }];
        });
#pragma clang diagnostic pop
    });

    describe(@"rejecting", ^{
        it(@"sets the error", ^{
            APIResponse *response = rejectedResponse(_object);
            expect(response.error).to.equal(_object);
        });

        it(@"calls the failure block when set on an already rejected response", ^{
            APIResponse *response = rejectedResponse(_object);
            response.failure = ^(id error) {
                expect(error).to.equal(_object);
            };
        });

        it(@"calls the failure block when the response is rejected", ^AsyncBlock{
            APIResponse *response = delayedRejectedResponse(_object);
            response.failure = ^(id error) {
                expect(error).to.equal(_object);
                done();
            };
        });

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
        it(@"cannot be rejected again", ^{
            APIResponse *response = [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
                reject(_object);
                expect(^{
                    reject(nil);
                }).to.raise(NSInternalInconsistencyException);
            }];
        });

        it(@"cannot be resolved", ^{
            APIResponse *response = [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
                reject(_object);
                expect(^{
                    resolve(nil);
                }).to.raise(NSInternalInconsistencyException);
            }];
        });
#pragma clang diagnostic pop
    });
});

SpecEnd

APIResponse *resolvedResponse(id object)
{
    return [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
        resolve(object);
    }];
};

APIResponse *delayedResolvedResponse(id object)
{
    return [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            resolve(object);
        });
    }];
}

APIResponse *rejectedResponse(id error)
{
    return [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
        reject(error);
    }];
}

APIResponse *delayedRejectedResponse(id error)
{
    return [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            reject(error);
        });
    }];
}