
//
//  Drink.m
//  CoffeeMachine
//
//  Created by System Administrator on 8/5/13.
//  Copyright (c) 2013 System Administrator. All rights reserved.
//

#import "Drink.h"

@implementation Drink

-(id)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.price = 0;
    }
    return self;
}
@synthesize price;
@synthesize name;

-(NSString*)description
{
    return [NSString stringWithFormat:@"name: %@, price: %ul", self.name, self.price];
}

- (id)copy
{
    Drink *drink = [[Drink alloc] init];
    drink.name = self.name;
    drink.price = self.price;
    
    return drink;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [self copy];
}

@end
