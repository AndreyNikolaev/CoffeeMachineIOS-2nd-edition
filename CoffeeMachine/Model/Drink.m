
//
//  Drink.m
//  CoffeeMachine
//
//  Created by System Administrator on 8/5/13.
//  Copyright (c) 2013 System Administrator. All rights reserved.
//

#import "Drink.h"

@implementation Drink

@synthesize price;
@synthesize name;

-(id)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.price = 0;
    }
    return self;
}

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

- (NSUInteger)hash
{
    NSUInteger hash = 0;
    hash += self.name.hash;
    hash += self.price;
    return hash;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"drinkName"];
    [encoder encodeObject:[NSNumber numberWithInteger:self.price] forKey:@"drinkPrice"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"drinkName"];
        self.price = (int)[coder decodeObjectForKey:@"drinkPrice"];
        }
    return self;
}

//isEqual must be overwrited, otherwise load from URL doesn't work fine 
-(BOOL)isEqual:(Drink *)other
{
    if([self.name isEqualToString:other.name] && self.price == other.price)
        return YES;
    else return NO;
}

@end
