//
//  THHudNode.h
//  Space Cat
//
//  Created by Vineet Tiwari on 2015-03-17.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface THHudNode : SKNode

@property (nonatomic) NSInteger lives;
@property (nonatomic) NSInteger score;

+ (instancetype) hudAtPosition:(CGPoint)position inFrame:(CGRect)frame;

- (void) addPoints:(NSInteger)points;

- (BOOL) loseLife;

@end
