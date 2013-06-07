//
//  MCUserManagerModel.m
//  UserManagerSystem2
//
//  Created by Yingyi Dai on 12-12-29.
//  Copyright (c) 2012年 SCUT. All rights reserved.
//

#import "MCUserManagerModel.h"
#import "MCUser.h"

@implementation MCUserManagerModel

static MCUserManagerModel* sharedSingleton_ = nil;

@synthesize currentUser;
@synthesize allUser;
@synthesize topScore;
@synthesize myScore;

#pragma mark implement singleton
+ (MCUserManagerModel *)sharedInstance
{
    if (sharedSingleton_ == nil) {
        sharedSingleton_ = [[super allocWithZone:NULL] init ];
        NSLog(@"create single user model");
    }
    return sharedSingleton_;
}

+(id)allocWithZone:(NSZone *)zone
{
    return [MCUserManagerModel sharedInstance];
}

- (id)copy
{
    return self;
}

-(id)retain
{
    return self;
}


- (id)init
{
    if (self = [super init]) {
        currentUser = [[MCUser alloc] init];
        allUser = [[NSMutableArray alloc] init];
        topScore = [[NSMutableArray alloc] init];
        myScore = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)dealloc{
    self.allUser = nil;
    self.topScore = nil;
    self.myScore = nil;
    [super dealloc];
}


@end
