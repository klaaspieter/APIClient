#import "SpecHelper.h"

#import "APIResourceNamer.h"

SpecBegin(APIResourceNamer)

__block APIResourceNamer *_namer;

describe(@"APIResourceNamer", ^{

    before(^{
        _namer = [[APIResourceNamer alloc] init];
    });

    describe(@"initialization", ^{
        it(@"has a default inflector", ^{
            expect(_namer.inflector).toNot.beNil();
        });

        it(@"can be initialized with a custom inflector", ^{
            APIInflector *inflector = [[APIInflector alloc] init];
            _namer = [[APIResourceNamer alloc] initWithInflector:inflector];
            expect(_namer.inflector).to.equal(inflector);
        });
    });

    describe(@"nameForResource:", ^{
        it(@"lowercases the resource name", ^{
            expect([_namer nameForResource:NSClassFromString(@"Product")]).to.equal(@"product");
        });

        it(@"underscores the resource name", ^{
            expect([_namer nameForResource:NSClassFromString(@"OrderLine")]).to.equal(@"order_line");
        });

        it(@"removes class prefixes", ^{
            expect([_namer nameForResource:[APIResourceNamer class]]).to.equal(@"resource_namer");
        });
    });

    describe(@"pluralizedNameForResource:", ^{
        it(@"pluralizes the resource name", ^{
            expect([_namer pluralizedNameForResource:[APIResourceNamer class]]).to.equal(@"resource_namers");
        });
    });
});

SpecEnd
