//
//  THSpaceDogNode.h
//  Space Cat
//
//  Created by Vineet Tiwari on 2015-03-16.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, THSpaceDogType) {
    THSpaceDogTypeA = 0,
    THSpaceDogTypeB = 1
};

@interface THSpaceDogNode : SKSpriteNode

@property (nonatomic, getter = isDamaged) BOOL damaged;
@property (nonatomic) THSpaceDogType type;

+ (instancetype) spaceDogOffType:(THSpaceDogType)type;

@end
