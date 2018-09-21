//
//  Contributer.m
//  GitHubTrending
//
//  Created by Developer on 05/09/2018.
//  Copyright © 2018 Developer. All rights reserved.
//

#import "Contributor.h"

@implementation Contributor

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.login = [dictionary objectForKey:@"login"];
        self.url = [dictionary objectForKey:@"url"];
        self.avatarUrl = [dictionary objectForKey:@"avatar_url"];
    }
    return self;
}

@end
