//
//  Drink.h
//  CoffeeMachine
//
//  Created by System Administrator on 8/5/13.
//  Copyright (c) 2013 System Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Drink : NSObject <NSCopying, NSCoding>

@property (strong) NSString *name;
@property int price;
-(NSString*)description;
- (BOOL)isEqual:(Drink*)other;
- (NSUInteger)hash;
- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)coder;
@end

