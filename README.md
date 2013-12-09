# APIClient

## Installation

APIClient is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "APIClient"

## Introduction

APIClient is a convention over configuration REST API client for Objective-C. APIClient attempts to do as little as possible to deal with conventional REST APIs.
If you're dealing with an unconventional API it's trivial to override the default behavior by implementing the protocols APIClient exposes.

## Usage

### Instantiating

There are two main ways to instantiate an APIClient instance. The first is by providing a baseURL:

    APIClient *client = [APIClient clientWithBaseURL:baseURL];

And the second by providing a configuration block:

    APIClient *client = [APIClient clientWithConfigurationBlock:^(APIClientConfiguration *config) {
        config.baseURL = baseURL;
    }];

The configuration block is passed a `APIClientConfiguration` instance which you can use to customize the components used by your client.
Take a look at the [APIClientConfiguration header](https://github.com/klaaspieter/APIClient/blob/master/Classes/APIClientConfiguration.h) to learn what can be customized.


### GET a resource collection

    APIResponse *response = [_client findAll:[Product class]];
    response.success = ^(NSArray *products) {
        NSLog(@"products: %@", products);
    };
    response.failure = ^(NSError *error) {
        NSLog(@"error: %@", error);
    };

### GET a single resource

    APIResponse *response = [_client findResource:[Product class] withID:@1];
    response.success = ^(Product *product) {
        NSLog(@"product: %@", product);
    };
    response.failure = ^(NSError *error) {
        NSLog(@"error: %@", error);
    };

### Process

Any APIClient request follows a number of steps. The entire process is as follows:

1. Ask the APIRouter to map an action on a resource to a URL. For example GET MyProduct becomes URL https://yourbaseurl.com/products
2. Make a request for the URL using the HTTPClient
3. Use the serializer to serialize the response body to Foundation objects
4. Map the Foundation objects to instances of the requested resource

Every step is abstracted into different components. An APIClient component is a formal protocol and a
default implementation of that protocol that follows REST conventions. If you need different behavior you can either create a subclass of APIClient's implentation or
create your own class that conforms to the protocol.

## Authors

Klaas Pieter Annema, klaaspieter@annema.me

## License

APIClient is available under the MIT license. See the LICENSE file for more info.
