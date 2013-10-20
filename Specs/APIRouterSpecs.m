//
//  APIRouterSpecs.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "SpecHelper.h"

#import "APIRouter.h"

SpecBegin(APIRouterSpecs)

__block APIRouter *_router;

describe(@"APIRouter", ^{
    before(^{
        _router = [[APIRouter alloc] init];
    });

    describe(@"initialization", ^{
        it(@"has a resource namer", ^{
            APIRouter *router = [[APIRouter alloc] init];
            expect(router.resourceNamer).notTo.beNil();
        });

        it(@"accepts other resource namers", ^{
            APIResourceNamer *namer = [[APIResourceNamer alloc] init];
            APIRouter *router = [[APIRouter alloc] initWithResourceNamer:namer];
            expect(router.resourceNamer).to.equal(namer);
        });
    });

    describe(@"routing", ^{
        describe(@"index actions", ^{
            it(@"routes to the pluralized resource name", ^{
                expect([_router pathForAction:@"index" onResource:[NSObject class]]).to.equal(@"objects");
            });
        });

        describe(@"show actions", ^{
            it(@"routes to the pluralized resource name and ID", ^{
                expect([_router pathForAction:@"show" onResource:[NSObject class] withArguments:@{@"id": @1}]).to.equal(@"objects/1");
            });

            it(@"routes to resource with non-numeric IDs", ^{
                expect([_router pathForAction:@"show" onResource:[NSObject class] withArguments:@{@"id": @"test"}]).to.equal(@"objects/test");
            });

            it(@"raises if the arguments doesn't contain an ID", ^{
                expect(^{
                    [_router pathForAction:@"show" onResource:[NSObject class] withArguments:@{}];
                }).to.raise(NSInvalidArgumentException);
            });

            it(@"raises if the ID argument can't be coerced into a string", ^{
                expect(^{
                    [_router pathForAction:@"show" onResource:[NSObject class] withArguments:@{@"id": [[NSObject alloc] init]}];
                }).to.raise(NSInvalidArgumentException);
            });
        });
    });
});

SpecEnd