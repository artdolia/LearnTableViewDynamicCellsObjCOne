//
//  RandomColor.m
//  L30_dynamic_cells
//
//  Created by Artsiom Dolia on 1/2/15.
//  Copyright (c) 2015 Artsiom Dolia. All rights reserved.
//

#import "RandomColor.h"

@implementation RandomColor

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.color = [self getRandomRGBColor];
    }
    return self;
}

-(UIColor *) getRandomRGBColor{
    
    CGFloat redComponent = (float)(arc4random()%256) / 255;
    CGFloat blueComponent = (float)(arc4random()%256) / 255;
    CGFloat greenComponent = (float)(arc4random()%256) / 255;
    
    return [UIColor colorWithRed:redComponent green:greenComponent blue:blueComponent alpha:1.f];
}

@end
