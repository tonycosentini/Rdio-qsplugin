//
//  RdioAPIClient.m
//  RdioSilver
//
//  Created by Tony Cosentini on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RdioAPIClient.h"

NSString * const kRdioBaseURLString = @"http://api.rdio.com/1/";
NSString * const kRdioAPIKey = @"7f5ndp9grpe27ha72w4dqhj2";
NSString * const kRdioSecretKey = @"DhNXczK9Hk";

@implementation RdioAPIClient

+ (RdioAPIClient *)sharedClient {
    static RdioAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kRdioBaseURLString]];
    });
    
    return _sharedClient;
}

@end
