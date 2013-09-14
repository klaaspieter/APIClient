#import "SpecHelper.h"

#import "APIClientConfiguration.h"

SpecBegin(APIClientConfigurationSpecs)

__block APIClientConfiguration *_configuration;
__block NSURL *_baseURL;
__block APIAFNetworkingHTTPClient *_httpClient;
__block APIRouter *_router;

beforeEach(^{
    _baseURL = [NSURL URLWithString:@"https://api.example.org"];
    _httpClient = [[APIAFNetworkingHTTPClient alloc] initWithBaseURL:_baseURL];
    _router = [[APIRouter alloc] init];
});

describe(@"APIClientConfiguration", ^{
    beforeEach(^{
        _httpClient = [[APIAFNetworkingHTTPClient alloc] initWithBaseURL:_baseURL];
        _router = [[APIRouter alloc] init];
    });

    it(@"creates a default httpClient with the configured baseURL", ^{
        _configuration = [APIClientConfiguration configurationWithBaseURL:_baseURL];
        expect(_configuration.httpClient).to.beInstanceOf([APIAFNetworkingHTTPClient class]);
        expect(_configuration.httpClient.baseURL).to.equal(_baseURL);
    });
    
    it(@"cannot be initialized without a baseURL", ^{
        expect(^{
            _configuration = [[APIClientConfiguration alloc] init];
        }).to.raise(NSInternalInconsistencyException);
    });

    it(@"can be initialized with a different httpClient", ^{
        _configuration = [[APIClientConfiguration alloc] initWithHTTPClient:_httpClient router:_router];
        expect(_configuration.httpClient).to.equal(_httpClient);
        expect(_configuration.httpClient.baseURL).to.equal(_baseURL);
    });

    it(@"cannot be initialized without a httpClient", ^{
        expect(^{
            _configuration = [[APIClientConfiguration alloc] initWithHTTPClient:nil router:_router];
        }).to.raise(NSInternalInconsistencyException);
    });

    it(@"has a default router", ^{
        _configuration = [APIClientConfiguration configurationWithBaseURL:_baseURL];
        expect(_configuration.router).to.beInstanceOf([APIRouter class]);
    });

    it(@"can be initialized with a different router", ^{
        _configuration = [[APIClientConfiguration alloc] initWithHTTPClient:_httpClient router:_router];
        expect(_configuration.router).to.equal(_router);
    });

    it(@"cannot be initialized without a router", ^{
        expect(^{
            _configuration = [[APIClientConfiguration alloc] initWithHTTPClient:_httpClient router:nil];
        }).to.raise(NSInternalInconsistencyException);
    });

});

SpecEnd
