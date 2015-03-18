//
//  THGamePlayScene.m
//  Space Cat
//
//  Created by Vineet Tiwari on 2015-03-16.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

#import "THGamePlayScene.h"
#import "THMachineNode.h"
#import "THSpaceCatNode.h"
#import "THProjectileNode.h"
#import "THSpaceDogNode.h"
#import "THGroundNode.h"
#import "THUtil.h"
#import <AVFoundation/AVFoundation.h>
#import "THHudNode.h"

@interface THGamePlayScene ()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTimeInterval;
@property (nonatomic) SKAction *damageSFX;
@property (nonatomic) SKAction *explodeSFX;
@property (nonatomic) SKAction *laserSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;


@end

@implementation THGamePlayScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.lastUpdateTimeInterval =  0;
        self.timeSinceEnemyAdded    =  0;
        self.addEnemyTimeInterval   =  1.25;
        self.totalGameTime          =  0;
        self.minSpeed               =  THSpaceDogMinSpeed;
        
        /* Setup your scene here */
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        THMachineNode *machine = [THMachineNode machineAtPosition:CGPointMake (CGRectGetMidX(self.frame), 12)];
        [self addChild:machine];
        
        THSpaceCatNode *spaceCat = [THSpaceCatNode spaceCatAtPosition:CGPointMake(machine.position.x, machine.position.y-2)];
        [self addChild:spaceCat];
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8);
        
        self.physicsWorld.contactDelegate = self;
        
        THGroundNode *ground = [THGroundNode groundWithSize:CGSizeMake(self.frame.size.width, 22)];
        [self addChild:ground];
        
        [self setupSounds];
        
        THHudNode *hud = [THHudNode hudAtPosition:CGPointMake(0, self.frame.size.height - 20) inFrame:self.frame];
        [self addChild:hud];
        
    }
    return self;
}

- (void) didMoveToView:(SKView *)view  {
    
    [self.backgroundMusic play];
}

- (void) setupSounds {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Gameplay" withExtension:@"mp3"];
    
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    self.backgroundMusic.numberOfLoops = -1;
    [self.backgroundMusic prepareToPlay];
    
    self.damageSFX  = [SKAction playSoundFileNamed:  @"Damage.caf" waitForCompletion:NO];
    self.explodeSFX = [SKAction playSoundFileNamed: @"Explode.caf" waitForCompletion:NO];
    self.laserSFX   = [SKAction playSoundFileNamed:   @"Laser.caf" waitForCompletion:NO];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        
        CGPoint position = [touch locationInNode:self];
        [self shootProjectileTowardsPosition:position];
    }
}

- (void) shootProjectileTowardsPosition:(CGPoint)position {
    THSpaceCatNode *spaceCat = (THSpaceCatNode *)[self childNodeWithName:@"SpaceCat"];
    [spaceCat performTap];
    
    THMachineNode *machine = (THMachineNode *)[self childNodeWithName:@"Machine"];
    
    THProjectileNode *projectile = [THProjectileNode projectileAtPosition:CGPointMake(machine.position.x, machine.position.y + machine.frame.size.height - 15)];
    [self addChild:projectile];
    [projectile moveTowardsPositioin:position];
    
    [self runAction:self.laserSFX];
}

- (void) addSpaceDog {
    
    NSUInteger randomSpaceDog = [THUtil randomWithMin:0 max:2];
    
    THSpaceDogNode *spaceDog = [THSpaceDogNode spaceDogOffType:randomSpaceDog];
    
    float dy = [THUtil randomWithMin: THSpaceDogMinSpeed max: THSpaceDogMaxSpeed];
    spaceDog.physicsBody.velocity = CGVectorMake(0, dy);
    
    float y = self.frame.size.height + spaceDog.size.height;
    float x = [THUtil randomWithMin: 10 + spaceDog.size.width max: self.frame.size.width - spaceDog.size.width - 10];
    
    spaceDog.position = CGPointMake(x, y);
    [self addChild:spaceDog];
    
}

- (void) update:(NSTimeInterval)currentTime {
    
    if (self.lastUpdateTimeInterval) {
        
        self.timeSinceEnemyAdded +=  currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime       +=  currentTime - self.lastUpdateTimeInterval;
    }
    
    if (self.timeSinceEnemyAdded >= self.addEnemyTimeInterval) {
    
        [self addSpaceDog];
        self.timeSinceEnemyAdded = 0;
        
    }
    
    self.lastUpdateTimeInterval = currentTime;
    
    if (self.totalGameTime > 480) {
        // 480 / 60 = 8 minutes
        self.addEnemyTimeInterval =  0.50;
        self.minSpeed             =  -160;
    }
    
    else if (self.totalGameTime > 240) {
        // 240 / 60 = 4 minutes
        self.addEnemyTimeInterval = 0.65;
        self.minSpeed             = -150;
    }
    
    else if (self.totalGameTime > 120) {
        // 120 / 60  = 2 minutes
        self.addEnemyTimeInterval = 0.75;
        self.minSpeed             = -125;
    }
    
    else if (self.totalGameTime > 30) {
        self.addEnemyTimeInterval = 1.00;
        self.minSpeed             = -100;
        
    }
    
}

- (void) didBeginContact:(SKPhysicsContact *)contact {
    
    SKPhysicsBody *firstBody, *secondBody;
    
    if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        
        firstBody  = contact.bodyA;
        secondBody = contact.bodyB;
        
    }
    else {
        
        firstBody  = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if(firstBody.categoryBitMask == THCollisionCategoryEnemy && secondBody.categoryBitMask == THCollisionCategoryProjectile) {
        
        THSpaceDogNode *spaceDog      =  (THSpaceDogNode *)firstBody.node;
        THProjectileNode *projectile  =  (THProjectileNode *)secondBody.node;
        
        [self addPoints:THPointsPerHit];
        
        [self runAction:self.explodeSFX];
        
        if ([spaceDog isDamaged]) {
            [self runAction:self.explodeSFX];
        
            [spaceDog removeFromParent];
            [projectile removeFromParent];
            [self createDebrisAtPosition:contact.contactPoint];
        }
        
        
    }
    else if(firstBody.categoryBitMask == THCollisionCategoryEnemy && secondBody.categoryBitMask == THCollisionCategoryGround) {
        
        THSpaceDogNode *spaceDog = (THSpaceDogNode *)firstBody.node;
        
        [self runAction:self.damageSFX];
        [spaceDog removeFromParent];
        [self createDebrisAtPosition:contact.contactPoint];
        
        [self loseLife];
        
    }
    
}

- (void) addPoints:(NSInteger)points {
    
    THHudNode *hud = (THHudNode *)[self childNodeWithName:@"HUD"];
    [hud addPoints:points];
}

- (void) loseLife {
    
    THHudNode *hud = (THHudNode *)[self childNodeWithName:@"HUD"];
    [hud loseLife];
}

- (void) createDebrisAtPosition:(CGPoint)position {

    NSInteger numberOfPieces = [THUtil randomWithMin:5 max:20];
    
    for (int i = 0; i < numberOfPieces; i++) {
        NSInteger randomPiece = [THUtil randomWithMin:1 max:4];
        NSString *imageName = [NSString stringWithFormat:@"debri_%ld", randomPiece];
        
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        debris.position = position;
        [self addChild:debris];
        
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = THCollisionCategoryDebris;
        debris.physicsBody.collisionBitMask = THCollisionCategoryDebris | THCollisionCategoryGround;
        debris.physicsBody.contactTestBitMask = 0;
        debris.name = @"Debris";
        debris.physicsBody.velocity = CGVectorMake([THUtil randomWithMin:-150 max:150], [THUtil randomWithMin:150 max:350]);
        
        [debris runAction:[SKAction waitForDuration:2.0] completion:^{[debris removeFromParent];}];
    }
    
    NSString *explosionPath = [[NSBundle mainBundle] pathForResource:@"Explosion" ofType:@"sks"];
    SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionPath];
    
    explosion.position = position;
    [self addChild:explosion];
    
    [explosion runAction:[SKAction waitForDuration:2.0] completion:^{[explosion removeFromParent];}];
    
}

@end































