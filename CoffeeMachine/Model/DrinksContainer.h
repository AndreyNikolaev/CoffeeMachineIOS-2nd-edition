//
//  DrinksContainer.h
//  CoffeeMachine
//
//  Created by System Administrator on 8/6/13.
//  Copyright (c) 2013 System Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Drink;

@interface DrinksContainer : NSObject<NSCoding>

@property (strong) NSMutableDictionary  *drinks;


- (void)addDrink:(Drink *)drink quantity:(NSUInteger)quantity;
- (void)addDrinkForFromPlist:(Drink *)drink quantity:(NSUInteger)quantity;
-(NSUInteger*)drinkQuantity:(Drink*) searchedDrink;
-(void)decreaseDrinkAmount:(Drink*) selectedDrink;
-(NSArray*)drinksArray;
-(NSMutableArray*)drinksString;
-(NSArray *)drinkNameAndQuantity;
-(void)loadDrinksFromPlist;
-(NSMutableArray*)dictsOfDrinksAndAmountsArray;
-(NSMutableArray*)drinkPricesString;

@end