//
//  THProjectileNode.m
//  Space Cat
//
//  Created by Vineet Tiwari on 2015-03-16.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

#import "THProjectileNode.h"

@implementation THProjectileNode

+ (instancetype) projectileAtPosition:(CGPoint)position {
    
    THProjectileNode *projectile = [self spriteNodeWithImageNamed:@"projectile_1"];
    projectile.position = position;
    projectile.name = @"Projectile";
    
    return projectile;
    
}

@end
