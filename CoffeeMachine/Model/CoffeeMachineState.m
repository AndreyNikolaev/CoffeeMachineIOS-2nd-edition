//
//  CoffeeMachineState.m
//  CoffeeX
//
//  Created by System Administrator on 8/13/13.
//  Copyright (c) 2013 System Administrator. All rights reserved.
//

#import "CoffeeMachineState.h"
#import "DrinksContainer.h"
#import "Drink.h"
#import "FileWriter.h"

@implementation CoffeeMachineState

-(id)init:(MoneyAmount*) newCoins : (DrinksContainer*) newDrinks
{
    self = [super init];
    if (self)
    {
        _coins = newCoins;
        _currentDrinksAmount=newDrinks;
        NSMutableArray* currentDrinks=[[NSMutableArray alloc]initWithArray:[_currentDrinksAmount drinksArray]];
        for(int i=0;i<[currentDrinks count];i++){
        }
              
    }
    return self;
}

-(DrinksContainer*)currentDrinks
{
    return _currentDrinksAmount;
}

-(NSMutableDictionary*)filtratedDrinks
{
    NSMutableDictionary* currentDrinks=[[NSMutableDictionary alloc] initWithDictionary:_currentDrinksAmount.drinks];
    for (Drink *storedDrink in [currentDrinks allKeys]) {
        if ([currentDrinks[storedDrink]integerValue] == 0) {
            [currentDrinks removeObjectForKey:storedDrink];
               }
    }
    return currentDrinks;
}

-(NSMutableArray*)getStateInArray
{
    NSMutableArray* stateArray=[[NSMutableArray alloc]initWithArray:[self.currentDrinksAmount dictsOfDrinksAndAmountsArray]];
    [stateArray addObject:[self.coins coinsValueAndAmount]];
    return stateArray;
}

-(void)saveStateToFile //may be better in FileWriter.m
{
    FileWriter*  fileWriter = [[FileWriter alloc] initWithFileName:@"writedFile.plist"];
    [fileWriter saveToPlist:[self getStateInArray]];
}

@end
