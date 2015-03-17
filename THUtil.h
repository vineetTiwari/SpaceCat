//
//  THUtil.h
//  Space Cat
//
//  Created by Vineet Tiwari on 2015-03-16.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int THProjectileSpeed = 400;

typedef NS_OPTIONS(NSUInteger, THCollisionCategory) {
    THCollisionCategoryEnemy      = 1 << 0,
    THCollisionCategoryProjectile = 1 << 1,
    THCollisionCategoryDebris     = 1 << 2,
    THCollisionCategoryGround     = 1 << 3,
};

@interface THUtil : NSObject

@end
