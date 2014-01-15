#import "SpecHelper.h"

#import "FakeAPI.h"
#import "APIClient.h"

#import "Product.h"

const double GIGABYTE = 1073741824;

SpecBegin(IntegrationSpec)

__block FakeAPI *_fakeAPI;
__block APIClient *_client;

describe(@"IntegrationSpec", ^{
    before(^{
        NSUInteger port = 3333;
        _fakeAPI = [[FakeAPI alloc] initWithPort:port];
        [_fakeAPI start];

        NSString *url = [NSString stringWithFormat:@"http://localhost:%i", 3333];
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
    });

    it(@"can GET a single resource", ^AsyncBlock{
        APIResponse *response = [_client findResource:[Product class] withID:@1];
        response.success = ^(Product *product) {
            expect(product.name).to.equal(@"Karma w/ 1GB");
            expect(product.price).to.equal(79);
            expect(product.inStock).to.beTruthy();
            expect(product.balanceIncrease).to.equal(1 * GIGABYTE);
            done();
        };
    });

    it(@"can create a new resource using POST", ^AsyncBlock{
        Product *product = [Product productWithName:@"Karma w/ 5GB" balanceIncrease:5 * GIGABYTE];
        APIResponse *response = [_client createResource:product];
        response.success = ^(Product *product) {
            expect(product.name).to.equal(@"Karma w/ 5GB");
            expect(product.balanceIncrease).to.equal(5 * GIGABYTE);
            expect(product.price).to.equal(129);
            done();
        };
    });
});

SpecEnd
