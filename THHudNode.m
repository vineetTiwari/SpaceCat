//
//  THHudNode.m
//  Space Cat
//
//  Created by Vineet Tiwari on 2015-03-17.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

#import "THHudNode.h"
#import "THUtil.h"

@implementation THHudNode

+ (instancetype) hudAtPosition:(CGPoint)position inFrame:(CGRect)frame {
    
    THHudNode *hud = [self node];
    hud.position   = position;
    hud.zPosition  = 10;
    
    SKSpriteNode *catHead = [SKSpriteNode spriteNodeWithImageNamed:@"HUD_cat_1"];
    catHead.position = CGPointMake(30, -10);
    [hud addChild:catHead];
    
    hud.lives = THMaxLives;
    
    SKSpriteNode *lastLifeBar;
    
    for (int i = 0; i < hud.lives; i++) {
        
        SKSpriteNode *lifeBar = [SKSpriteNode spriteNodeWithImageNamed:@"HUD_life_1"];
        lifeBar.name = [NSString stringWithFormat:@"Life%d", i + 1];
        
        [hud addChild:lifeBar];
        
        if (lastLifeBar == nil) {
            lifeBar.position = CGPointMake(catHead.position.x + 30, catHead.position.y);
        }
        else {
            lifeBar.position = CGPointMake(lastLifeBar.position.x + 10, lastLifeBar.position.y);
        }
        
        lastLifeBar = lifeBar;
    }
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    
    scoreLabel.name                    =  @"Score";
    scoreLabel.text                    =  @"0";
    scoreLabel.fontSize                =  24;
    scoreLabel.horizontalAlignmentMode =  SKLabelHorizontalAlignmentModeRight;
    scoreLabel.position                =  CGPointMake(frame.size.width - 20, -10);
    [hud addChild:scoreLabel];

    return hud;
}

@end





































