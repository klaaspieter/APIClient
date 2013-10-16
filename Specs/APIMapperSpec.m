#import "SpecHelper.h"

#import "APIMapper.h"

#import "APITestMappingProvider.h"
#import "Product.h"

SpecBegin(APIMapper)

__block APIMapper *_mapper;
__block id _mappingProvider;

describe(@"APIMapper", ^{

    before(^{
        _mappingProvider = [[APITestMappingProvider alloc] init];
        _mapper = [[APIMapper alloc] initWithMappingProvider:_mappingProvider];
    });

    it(@"keeps a reference to the mapping provider", ^{
        expect(_mapper.mappingProvider).to.equal(_mappingProvider);
    });

    it(@"maps value to an instance using a mapping", ^{
        NSDictionary *values = @{
            @"name": @"Karma",
            @"price": @(79)
        };

        NSDictionary *mapping = [[[APITestMappingProvider alloc] init] mappingForResource:[Product class]];

        Product *product = [[Product alloc] init];
        [_mapper mapValuesFrom:values toInstance:product usingMapping:mapping];
        expect(product.name).to.equal(@"Karma");
        expect(product.price).to.equal(79);
    });
});

SpecEnd