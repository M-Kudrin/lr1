//
//  Repository.h
//  GitHubTrending
//
//  Created by Developer on 24/08/2018.
//  Copyright © 2018 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contributor.h"

@interface Repository : NSObject

@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *descrtion;
@property (assign, nonatomic) NSInteger forks;
@property (assign, nonatomic) NSInteger stars;
@property (strong, nonatomic) NSString *language;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSArray<Contributor *> *contributors;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
