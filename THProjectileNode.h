//
//  THProjectileNode.h
//  Space Cat
//
//  Created by Vineet Tiwari on 2015-03-16.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface THProjectileNode : SKSpriteNode

+ (instancetype) projectileAtPosition:(CGPoint)position;

- (void) moveTowardsPositioin:(CGPoint)position;

@end
