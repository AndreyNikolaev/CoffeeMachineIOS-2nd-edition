//
//  DrinksContainer.h
//  CoffeeMachine
//
//  Created by System Administrator on 8/6/13.
//  Copyright (c) 2013 System Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Drink;

@interface DrinksContainer : NSObject

@property (strong) NSMutableDictionary  *drinks;
@property BOOL additionClosed;

- (void)addDrink:(Drink *)drink quantity:(NSUInteger)quantity;
-(NSUInteger*)getDrinkQuantity:(Drink*) drink;
-(void)decreaseDrinkAmount:(Drink*) drink;
-(NSMutableArray*)getDrinks;
-(NSMutableArray*)getStringDrinks;
-(void)setSomeDrinks;
-(DrinksContainer*)commit;
-(NSMutableArray *)drinkNameAndQuantityToString;
@end