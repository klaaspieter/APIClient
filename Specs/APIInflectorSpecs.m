//
//  APIInflectorSpecs.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "SpecHelper.h"

#import "APIInflector.h"

SpecBegin(APIInflectorSpecs)

describe(@"APIInflector", ^{

    it(@"can pluralize", ^{
        APIInflector *inflector = [[APIInflector alloc] init];
        expect([inflector pluralize:@"object"]).to.equal(@"objects");
    });

    it(@"can underscore", ^{
        APIInflector *inflector = [[APIInflector alloc] init];
        expect([inflector underscore:@"TestObject"]).to.equal(@"test_object");
    });
});

SpecEnd