//
//  VOProfilePictureView.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/30/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VOProfilePictureView.h"

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
    _profilePicture = [[VOProfilePictureStore sharedInstance] profilePictureForUser:user];
    [self addSubview:_profilePicture];
    [self layoutProfilePicture];
}

#pragma mark - Layout

- (void)layoutProfilePicture {
    
    NSAssert(self.profilePicture != nil,
             @"profilPicture must be initialized in before calling layoutProfilePicture.");
    
    NSAssert(self.profilePicture.superview != nil,
             @"profilePicture must have a subview before calling layoutProfilePicture.");
    
    UIView *superview = self.profilePicture.superview;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_profilePicture);
    
    static NSString *const verticalVFL = @"V:|[_profilePicture]|";

    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:verticalVFL
                                                options:0
                                                metrics:nil
                                                  views:views];
    
    static NSString *const horizontalVFL = @"H:|[_profilePicture]|";
    
    NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:horizontalVFL
                                                options:0
                                                metrics:nil
                                                  views:views];

    self.profilePicture.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addConstraints:verticalConstraints];
    [superview addConstraints:horizontalConstraints];
}


@end
