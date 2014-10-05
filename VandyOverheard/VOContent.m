//
//  VOContent.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VOContent.h"

#import "VONetworkAdapter.h"
#import "VONetworkConstants.h"

#import "VOUser.h"

@implementation VOContent

#pragma mark - Initialization

- (instancetype)initWithJson:(NSDictionary *)json {
    self = [super init];
    if (self) {
#warning This does not account for posts made by non-users (Organizations aka VandyApps)
#warning Does not account for users with middle names
        NSArray *name = [json[NetworkConstantFrom][NetworkConstantFullName] componentsSeparatedByString:@" "];
        NSString *facebookId = json[NetworkConstantFrom][NetworkConstantId];
        _author = [[VOUser alloc] initWithFirstName:name[0]
                                           lastName:name[1]
                                                 id:facebookId];
        
        _body = json[NetworkConstantContent];

        if (json[NetworkConstantLikeCount]) {
            _likeCount = [json[NetworkConstantLikeCount] integerValue];
        }
        else if (json[NetworkConstantLikeList]) {
            _likeCount = [json[NetworkConstantLikeList][NetworkConstantData] count];
        }

        id facebookDate = json[NetworkConstantCreationDate];
        _creationDate = NSDateFromFacebookDate(facebookDate);
    }
    return self;
}


- (instancetype)init {
    NSAssert(NO, @"Use designated initializer initWithJson: when creating content.");
    return nil;
}


#pragma mark - Convienience Methods

- (BOOL)isLikedByUser:(VOUser *)user {
    return NO;
}


@end
