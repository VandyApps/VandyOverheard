//
//  VOPhotoStore.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/9/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class VOPost;

typedef void(^PhotoBlock)(UIImage *image);

@interface VOPhotoStore : NSObject

/**
 * @abstract
 *  Get the photo for a particular post.
 */
- (void)photoForUrl:(NSURL *)url block:(PhotoBlock)block;

@end
