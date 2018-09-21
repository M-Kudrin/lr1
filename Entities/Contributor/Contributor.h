//
//  Contributor.h
//  GitHubTrending
//
//  Created by Developer on 05/09/2018.
//  Copyright © 2018 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contributor : NSObject

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *login;
@property (strong, nonatomic) NSString *avatarUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
