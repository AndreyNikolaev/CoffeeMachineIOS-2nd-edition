//
//  Coin.m
//  CoffeeMachine
//
//  Created by System Administrator on 8/5/13.
//  Copyright (c) 2013 System Administrator. All rights reserved.
//

#import "Coin.h"

@implementation Coin

-(id)init
{
    self = [super init];
    if (self) {
        //init code here
        self.value = 0;
       
    }
    return self;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"%d", self.value];
}
- (id)copy
{
    Coin *coin  = [[Coin alloc] init];
    coin.value = self.value;
      
    return coin;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [self copy];
}
- (NSComparisonResult)compare:(Coin *)otherObject{
    return [[NSNumber numberWithInt:self.value] compare:[NSNumber numberWithInt:otherObject.value]];
}

@end
