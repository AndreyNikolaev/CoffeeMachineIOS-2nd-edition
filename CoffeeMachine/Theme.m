//
//  Theme.m
//  CoffeeMachine
//
//  Created by dancho on 10/3/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "Theme.h"

@implementation Theme
static Theme *sharedInstance = nil;

+ (Theme *)sharedTheme
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

- (UIFont *)coffeeFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Arial" size:size];
}

-(UIColor *)lblBackColor
{
    return [UIColor redColor];
}

-(UIImage *) backGroudImage
{
    return [UIImage imageNamed:@"back.png"];//
}

@end
