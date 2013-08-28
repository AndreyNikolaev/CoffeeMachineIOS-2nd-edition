//
//  CoffeeMachineState.h
//  CoffeeX
//
//  Created by System Administrator on 8/13/13.
//  Copyright (c) 2013 System Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoneyAmount.h"
#import "DrinksContainer.h"
@interface CoffeeMachineState : NSObject

    @property(strong)MoneyAmount* coins;
    @property(strong)DrinksContainer* currentDrinksAmount;
    @property(strong)DrinksContainer* initialDrinksAmount;


-(MoneyAmount*) getCoins;
-(void)setCoins:(MoneyAmount*)newCoins;
-(DrinksContainer*) getCurrentDrinks;
-(DrinksContainer*) getInitialDrinks;
-(NSMutableArray*)getFiltratedDrinks;

@end
