//
//  VOProfilePictureView.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/30/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VOProfilePictureView.h"

#import "BMAutolayoutBuilder.h"
#import "VOAppContext.h"
#import "VOProfilePictureStore.h"

@interface VOProfilePictureView ()

/**
 * @abstract
 *  The profile picture inside this view.
 */
@property (nonatomic, strong) FBProfilePictureView *profilePicture;

/**
 * @abstract
 *  Setup the constraints associated with the
 *  profile picture.
 *
 * @discussion
 *  This method assumes that the profile picture
 *  is initialized and is added to the view hierarchy.
 */
- (void)layoutProfilePicture;

@end

@implementation VOProfilePictureView

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}


#pragma mark - Accessors

- (void)setUser:(VOUser *)user {
    _user = user;
    [_profilePicture removeFromSuperview];
    _profilePicture = [[VOAppContext sharedInstance].profilePictureStore profilePictureForUser:user];
    [self addSubview:_profilePicture];
    [self layoutProfilePicture];
}

#pragma mark - Layout

- (void)layoutProfilePicture {
    
    NSArray *constraints = [BMAutolayoutBuilder constraintsForView:self.profilePicture
                                                        withInsets:UIEdgeInsetsZero];
    
    self.profilePicture.translatesAutoresizingMaskIntoConstraints = NO;
    [self.profilePicture.superview addConstraints:constraints];
}


@end
