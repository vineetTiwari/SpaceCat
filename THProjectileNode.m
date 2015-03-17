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
    [projectile setupAnimation];
    
    return projectile;
    
}

- (void) setupAnimation {
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"projectile_1"],
                          [SKTexture textureWithImageNamed:@"projectile_2"],
                          [SKTexture textureWithImageNamed:@"projectile_3"]];
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    SKAction *repeatAction = [SKAction repeatActionForever:animation];
    [self runAction:repeatAction];
}

- (void) moveTowardsPositioin:(CGPoint)position {
    //slope = (y3 - y1) / (x3 - x1)
    float slope = (position.y - self.position.y) / (position.x - self.position.x);
    
    //slope = (y2 - y1) / (x2 - x1)
    //slope(x2 - x1) + y1 = y2
    //slope * x2 - slope * x1 + y1 = y2
    
    float offscreneX;
    
    if (position.x <= self.position.x) {
        
        offscreneX = -10;
    }
    else {
        
        offscreneX = self.parent.frame.size.width + 10;
    }
    
    float offscreneY = slope * offscreneX - slope * self.position.x + self.position.y;
    
    CGPoint pointOffscrene = CGPointMake(offscreneX, offscreneY);
    
    float distanceA = pointOffscrene.y - self.position.y;
    float distanceB = pointOffscrene.x - self.position.x;
    
    float distanceC = sqrtf( powf(distanceA, 2) + powf(distanceB, 2));
    
    //time = distance / speed
    
    float time = distanceC / 100;
    
    SKAction *moveProjectile = [SKAction moveTo:pointOffscrene duration:time];
    
    [self runAction:moveProjectile];
    
    
}

@end





































