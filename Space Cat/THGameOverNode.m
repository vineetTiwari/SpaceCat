//
//  THGameOverNode.m
//  Space Cat
//
//  Created by Vineet Tiwari on 2015-03-18.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

#import "THGameOverNode.h"

@implementation THGameOverNode

+ (instancetype) gameOverAtPosition:(CGPoint)position {
    
    THGameOverNode *gameOver   =  [self node];
    
    SKLabelNode *gameOverLabel =  [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    gameOverLabel.name         =  @"GameOver";
    gameOverLabel.text         =  @"Game Over";
    gameOverLabel.fontSize     =  48;
    gameOverLabel.position     =  position;
    
    [gameOver addChild:gameOverLabel];
    
    return gameOver;
}

@end
