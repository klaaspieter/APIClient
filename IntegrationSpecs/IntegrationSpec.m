#import "SpecHelper.h"

#import "FakeAPI.h"
#import "APIClient.h"

#import "Product.h"

SpecBegin(IntegrationSpec)

__block APIClient *_client;

describe(@"IntegrationSpec", ^{
    before(^{
        NSUInteger port = 3333;

        FakeAPI *fakeAPI = [[FakeAPI alloc] initWithPort:port];
        [fakeAPI start];

        NSString *url = [NSString stringWithFormat:@"http://localhost:%i", port];
        _client = [APIClient clientWithBaseURL:[NSURL URLWithString:url]];
    });

    it(@"can GET a collection of resources", ^AsyncBlock{
        APIResponse *response = [_client findAll:[Product class]];
        response.success = ^(NSArray *products) {
            expect(products).to.haveCountOf(2);
            done();
        };
    });
});

SpecEnd
