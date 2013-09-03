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
-(NSUInteger*)getDrinkQuantity:(Drink*) drink;
-(void)decreaseDrinkAmount:(Drink*) drink;
-(NSMutableArray*)getDrinks;
-(NSMutableArray*)getStringDrinks;
-(void)setSomeDrinks;
-(DrinksContainer*)commit;
-(NSMutableArray *)drinkNameAndQuantityToString;
-(void)loadDrinksFromPlist;
-(void)saveDrinksToPlist;
- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)coder;
- (void) save:(DrinksContainer*)drinksContainer;
- (DrinksContainer*) load;
-(NSMutableArray*) getArrayFromDictsOfDrinksAndAmounts;
<<<<<<< HEAD


=======
>>>>>>> 1c1e4939e8aa04eafef7aa15ae8ef0896c21e6b7
@end