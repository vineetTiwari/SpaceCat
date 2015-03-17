//
//  THUtil.m
//  Space Cat
//
//  Created by Vineet Tiwari on 2015-03-16.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

#import "THUtil.h"

@implementation THUtil

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max {
    
    return arc4random()%(max - min) + min;
}

@end
