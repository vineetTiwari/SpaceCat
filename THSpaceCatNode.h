//
//  THSpaceCatNode.h
//  Space Cat
//
//  Created by Vineet Tiwari on 2015-03-16.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface THSpaceCatNode : SKSpriteNode

+ (instancetype) spaceCatAtPosition:(CGPoint)position;

- (void) performTap;

@end
