//
//  DrinksContainer.m
//  CoffeeMachine
//
//  Created by System Administrator on 8/6/13.
//  Copyright (c) 2013 System Administrator. All rights reserved.
//

#import "DrinksContainer.h"
#import "Drink.h"
#import "FileReader.h"

@implementation DrinksContainer

-(id)init
{
    self = [super init];
    if (self) {
        self.drinks = [NSMutableDictionary dictionary];
    }
    return self;
}

//adding a new drink and quantity into drinks dictionary
- (void)addDrink:(Drink *)drink quantity:(NSUInteger)quantity
{
    BOOL drinkFound = NO;
    for (Drink *storedDrink in [self.drinks allKeys]) {
        if ([storedDrink isEqual:drink]) {
            drinkFound = YES;
            [self.drinks setObject:@(quantity + [self.drinks[storedDrink] intValue]) forKey:storedDrink];
            break;
        }
    }
    if (!drinkFound) {
        [self.drinks setObject:@(quantity) forKey:drink];
    }
}

//adding a drink into drinks dictionary
- (void)addDrinkForFromPlist:(Drink *)drink quantity:(NSUInteger)quantity
{
    BOOL drinkFound = NO;
    for (Drink *storedDrink in [self.drinks allKeys]) {
        if ([storedDrink isEqual:drink]) {
            drinkFound = YES;
            [self.drinks setObject:@(quantity ) forKey:storedDrink];
            break;
        }
    }
    
    if (!drinkFound) {
        [self.drinks setObject:@(quantity) forKey:drink];
    }
}



//get all keys of drinks dictionary
-(NSArray*)drinksArray
{   NSArray* tempDrinks=[[NSArray alloc]initWithArray:[self.drinks allKeys]];
    return tempDrinks;
}

//get all drink names as string
-(NSArray*)drinksString
{
    NSMutableArray* stringOfDrinksArray=[[NSMutableArray alloc]init];
    for (Drink *storedDrink in [self.drinks allKeys]) {
        [stringOfDrinksArray addObject:[NSString stringWithFormat:@"%@",storedDrink.name] ];
    }
    return stringOfDrinksArray;
}

// get all drink prices as string
-(NSArray*)drinkPricesString
{
    NSMutableArray* stringOfDrinksArray=[[NSMutableArray alloc]init];
    for (Drink *storedDrink in [self.drinks allKeys]) {
        [stringOfDrinksArray addObject:[NSString stringWithFormat:@"%d",storedDrink.price]];
    }
    return stringOfDrinksArray;
}

// get drink name and quantity as string
-(NSArray*)drinkNameAndQuantity
{
    NSMutableArray* drinkNameAndQuantity=[[NSMutableArray alloc]init];
    for (Drink *drink in [self.drinks allKeys]) {
        [drinkNameAndQuantity addObject:[NSString stringWithFormat:@"%@ - amount: %d",drink.name,[self.drinks[drink]integerValue]]];
    }
    return drinkNameAndQuantity;
}


-(NSUInteger*)drinkQuantity:(Drink *)searchedDrink
{
    NSUInteger* quantity=0;
    for (Drink *storedDrink in [self.drinks allKeys]) {
        if ([searchedDrink.name isEqualToString:storedDrink.name]) {
            break;
        }
    }
    return quantity;
}

//decreasing drink quantity
-(void)decreaseDrinkAmount:(Drink *)selectedDrink
{
    for (Drink *storedDrink in [self.drinks allKeys]) {
        if ([selectedDrink.name isEqualToString:storedDrink.name]) {
            [self.drinks setObject:@([self.drinks[storedDrink] intValue]-1) forKey:storedDrink];
            break;
        }
    }
}

-(void)loadDrinksFromPlist
{
    FileReader *file = [[FileReader alloc] initWithFileName:@"writedFile.plist"];
    NSDictionary *dictDrinks = [[NSDictionary alloc] initWithDictionary:[file getDictAtIndex:0]];
    NSDictionary *dictDrinksAmounts = [[NSDictionary alloc] initWithDictionary:[file getDictAtIndex:1]];
    int i = 0;
    Drink  *drink =[ [Drink alloc] init];
    NSArray* amounts = [[NSArray alloc] initWithArray:[dictDrinksAmounts allValues]];
    for(NSString* currentDrink in [dictDrinks allKeys])
    {
        drink.name = currentDrink;
        drink.price = [dictDrinks[currentDrink] integerValue ];
        [self addDrinkForFromPlist:drink quantity:[[amounts objectAtIndex:i] integerValue ]];
        i++;
    }
}

//getting array of dictionaries of drink names and quantities
-(NSMutableArray*) dictsOfDrinksAndAmountsArray
{
    NSMutableArray* drinksArray = [[NSMutableArray alloc] init];
    NSMutableDictionary* drinksDict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* drinksAmountsDict = [[NSMutableDictionary alloc] init];
    
    for(Drink* currentDrink in [self.drinks allKeys] ){
        [drinksDict setObject:[NSNumber numberWithInt:currentDrink.price] forKey:currentDrink.name];
        [drinksAmountsDict setObject:[NSNumber numberWithInt:[self.drinks[currentDrink] intValue ] ] forKey:currentDrink.name];
    }
    [drinksArray addObject:drinksDict];
    [drinksArray addObject:drinksAmountsDict];
    return drinksArray;
}



//dont need this methods, warning when remove them
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:[self.drinks allKeys]forKey:@"Drinks"];
    [encoder encodeObject:[self.drinks allValues] forKey:@"Amounts"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        [self.drinks setObject:[coder decodeObjectForKey:@"Amounts"] forKey:[coder decodeObjectForKey:@"Drinks"]];
    }
    return self;
}

@end
