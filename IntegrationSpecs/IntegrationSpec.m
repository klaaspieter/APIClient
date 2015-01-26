#import "SpecHelper.h"

#import "FakeAPI.h"
#import "APIClient.h"

#import "Product.h"

SpecBegin(IntegrationSpec)

__block FakeAPI *_fakeAPI;
__block APIClient *_client;

describe(@"IntegrationSpec", ^{
    before(^{
        NSUInteger port = 3333;
        _fakeAPI = [[FakeAPI alloc] initWithPort:port];
        [_fakeAPI start];

        NSString *url = [NSString stringWithFormat:@"http://localhost:%ld", port];
        _client = [APIClient clientWithBaseURL:[NSURL URLWithString:url]];
    });

    after(^{
        [_fakeAPI stop];
    });

    it(@"can GET a collection of resources", ^AsyncBlock{
        APIResponse *response = [_client findAll:[Product class]];
        response.success = ^(NSArray *products) {
            expect(products).to.haveCountOf(2);
            done();
        };
        response.failure = ^(NSError *error) {
            expect(nil).toNot.beNil(); // Fail early
            done();
        };
    });

    it(@"can GET a single resource", ^AsyncBlock{
        APIResponse *response = [_client findResource:[Product class] withID:@1];
        response.success = ^(Product *product) {
            expect(product.name).to.equal(@"Karma w/ 1GB");
            expect(product.price).to.equal(79);
            expect(product.inStock).to.beTruthy();
            expect(product.balanceIncrease).to.equal(1073741824);
            done();
        };
        response.failure = ^(NSError *error) {
            expect(nil).toNot.beNil(); // Fail early
            done();
        };
    });
});

SpecEnd
