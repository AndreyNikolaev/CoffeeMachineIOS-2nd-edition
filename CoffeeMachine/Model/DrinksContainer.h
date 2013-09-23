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
@property BOOL additionClosed;

- (void)addDrink:(Drink *)drink quantity:(NSUInteger)quantity;
- (void)addDrinkForFromPlist:(Drink *)drink quantity:(NSUInteger)quantity;
-(NSUInteger*)getDrinkQuantity:(Drink*) searchedDrink;
-(void)decreaseDrinkAmount:(Drink*) selectedDrink;
-(NSArray*)getDrinks;
-(NSMutableArray*)getStringDrinks;
-(DrinksContainer*)commit;
-(NSMutableArray *)drinkNameAndQuantityToString;
-(void)loadDrinksFromPlist;
- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)coder;
-(NSMutableArray*) getArrayFromDictsOfDrinksAndAmounts;
-(NSMutableArray*)getStringDrinkPrices;
-(BOOL)isAdditionClosed;

@end