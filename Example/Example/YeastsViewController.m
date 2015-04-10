//
//  BreweriesViewController.m
//  Example
//
//  Created by Klaas Pieter Annema on 21-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "YeastsViewController.h"

#import "APIClient.h"

#import "HTTPClient.h"
#import "Mapper.h"
#import "Yeast.h"

@interface YeastsViewController () <APIMappingProvider>
@property (nonatomic, readwrite, strong) NSArray *yeasts;
@end

@implementation YeastsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    APIClient *client = [APIClient clientWithConfigurationBlock:^(APIClientConfiguration *configuration) {
        NSURL *baseURL = [NSURL URLWithString:@"http://api.brewerydb.com/v2"];
        configuration.httpClient = [[HTTPClient alloc] initWithBaseURL:baseURL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        configuration.mapper = [[Mapper alloc] initWithMappingProvider:self];
    }];

    APIResponse *response = [client findAll:[Yeast class]];
    response.success = ^(NSArray *yeasts) {
        self.yeasts = yeasts;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    };

    response.failure = ^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:error.localizedDescription
                                   message:error.localizedRecoverySuggestion
                                  delegate:nil cancelButtonTitle:@"Dismiss"
                          otherButtonTitles:nil] show];
    };
}

- (NSDictionary *)mappingsForResource:(Class)resource;
{
    return @{@"yeastType": @"type", @"description": @"information"};
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.yeasts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    Yeast *yeast = self.yeasts[indexPath.row];
    cell.textLabel.text = yeast.name;
    cell.detailTextLabel.text = yeast.type;
    
    return cell;
}

@end
