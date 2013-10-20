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
});

SpecEnd
