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
        it(@"routes index actions to the pluralized resource name", ^{
            expect([_router pathForAction:@"index" onResource:[NSObject class]]).to.equal(@"objects");
        });
    });
});

SpecEnd