#import "SpecHelper.h"

#import "APIMapper.h"

#import "APITestMappingProvider.h"
#import "Product.h"

SpecBegin(APIMapper)

__block APIMapper *_mapper;
__block id _mappingProvider;

__block NSDictionary *_values;
__block Product *_product;

describe(@"APIMapper", ^{

    before(^{
        _mappingProvider = [[APITestMappingProvider alloc] init];
        _mapper = [[APIMapper alloc] initWithMappingProvider:_mappingProvider];

        _values = @{
             @"name": @"Karma",
             @"price": @(79)
        };
        _product = [[Product alloc] init];
    });

    it(@"keeps a reference to the mapping provider", ^{
        expect(_mapper.mappingProvider).to.equal(_mappingProvider);
    });

    it(@"maps value to an instance using a mapping", ^{
        [_mapper mapValuesFrom:_values toInstance:_product];
        expect(_product.name).to.equal(@"Karma");
        expect(_product.price).to.equal(79);
    });

    it(@"raises when attempting to map without a mapping provider", ^{
        NSString *reason = @"Attempt to map a resource without a mapping provider. Please instantiate your mapper with a mapping provider.";
        _mapper.mappingProvider = nil;
        expect(^{
            [_mapper mapValuesFrom:_values toInstance:_product];
        }).to.raiseWithReason(NSInternalInconsistencyException, reason);
    });
});

SpecEnd