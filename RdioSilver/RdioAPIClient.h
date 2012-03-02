//
//  RdioAPIClient.h
//  RdioSilver
//
//  Created by Tony Cosentini on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AFHTTPClient.h"

@interface RdioAPIClient : AFHTTPClient
+ (RdioAPIClient *)sharedClient;
@end
