//
//  Repository.m
//  GitHubTrending
//
//  Created by Developer on 24/08/2018.
//  Copyright © 2018 Developer. All rights reserved.
//

#import "Repository.h"

@implementation Repository

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.author = [dictionary objectForKey:@"author"];
        self.name = [dictionary objectForKey:@"name"];
        self.forks = [[dictionary objectForKey:@"forks"] integerValue];
        self.language = [dictionary objectForKey:@"language"];
        self.stars = [[dictionary objectForKey:@"stars"] integerValue];
        self.url = [dictionary objectForKey:@"url"];
        self.descrtion = [dictionary objectForKey:@"description"];
    }
    return self;
}

@end
