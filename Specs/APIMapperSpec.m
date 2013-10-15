#import "SpecHelper.h"

#import "APIMapper.h"

#import "Product.h"

SpecBegin(APIMapper)

__block APIMapper *_mapper;

describe(@"APIMapper", ^{
    before(^{
        _mapper = [[APIMapper alloc] init];
    });

    it(@"maps value to an instance using a mapping", ^{
        NSDictionary *values = @{
            @"name": @"Karma",
            @"price": @(79)
        };

        NSDictionary *mapping = @{@"name": @"name", @"price": @"price"};

        Product *product = [[Product alloc] init];
        [_mapper mapValuesFrom:values toInstance:product usingMapping:mapping];
        expect(product.name).to.equal(@"Karma");
        expect(product.price).to.equal(79);
    });
});

SpecEnd