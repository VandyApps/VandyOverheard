//
//  BMAutolayoutMacros.h
//  VandyOverheard
//
//  Created by Brendan McNamara on 10/5/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#ifndef VandyOverheard_BMAutolayoutMacros_h
#define VandyOverheard_BMAutolayoutMacros_h

#define AssertViewNotNil(view) NSAssert(view != nil, @"View cannot be nil.")

#define AssertSuperviewNotNil(view) NSAssert(view.superview != nil, @"Superview cannot be nil.")

#define AssertConstraintReady(view) AssertViewNotNil(view); AssertSuperviewNotNil(view)

#endif
