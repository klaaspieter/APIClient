#import "SpecHelper.h"

#import "FakeAPI.h"
#import "APIClient.h"

SpecBegin(IntegrationSpec)

__block APIClient *_client;

describe(@"IntegrationSpec", ^{
    before(^{
        NSUInteger port = 3333;

        FakeAPI *fakeAPI = [[FakeAPI alloc] initWithPort:port];
        [fakeAPI start];

        NSString *url = [NSString stringWithFormat:@"localhost:%i", port];
        _client = [APIClient clientWithBaseURL:[NSURL URLWithString:url]];
    });

    it(@"can GET a collection of resources", ^{
    });
});

SpecEnd
