//
//  THTitleScene.m
//  Space Cat
//
//  Created by Vineet Tiwari on 2015-03-16.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

#import "THTitleScene.h"
#import "THGamePlayScene.h"

@implementation THTitleScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    THGamePlayScene *gamePlayScene = [THGamePlayScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition flipVerticalWithDuration:1.0];
    [self.view presentScene:gamePlayScene transition:transition];
}

@end
