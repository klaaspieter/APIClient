#import "SpecHelper.h"

#import "APIMapper.h"

#import "Product.h"

@interface APITestMappingProvider : NSObject <APIMappingProvider>
@end

@implementation APITestMappingProvider
- (NSDictionary *)mappingsForResource:(Class)resource;
{
    return @{@"productName": @"name"};
}
@end

SpecBegin(APIMapper)

__block APIMapper *_mapper;

describe(@"APIMapper", ^{

    before(^{
        _mapper = [[APIMapper alloc] init];
    });

    it(@"maps value to an instance using a mapping", ^{
        NSDictionary *values = @{@"product": @{@"name": @"Karma"}};
        Product *product = [_mapper mapValues:values toResource:[Product class]];
        expect(product.name).to.equal(@"Karma");
    });

    it(@"can map collections", ^{
        NSDictionary *values = @{@"products": @[@{@"name": @"Karma"}]};
        NSArray *products = [_mapper mapValues:values toResources:[Product class]];
        Product *product = products[0];
        expect(product.name).to.equal(@"Karma");
    });

    it(@"maps snake case to camelCase", ^{
        NSDictionary *values = @{@"product": @{@"in_stock": @(true)}};
        Product *product = [_mapper mapValues:values toResource:[Product class]];
        expect(product.inStock).to.beTruthy();
    });

    it(@"can be configured with different mappings", ^{
        NSDictionary *values = @{@"product": @{@"productName": @"Karma"}};
        _mapper = [[APIMapper alloc] initWithMappingProvider:[[APITestMappingProvider alloc] init]];
        Product *product = [_mapper mapValues:values toResource:[Product class]];
        expect(product.name).to.equal(@"Karma");
    });
});

SpecEnd