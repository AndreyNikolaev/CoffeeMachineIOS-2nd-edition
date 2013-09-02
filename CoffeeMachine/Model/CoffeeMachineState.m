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

@implementation CoffeeMachineState
@synthesize currentDrinksAmount;
@synthesize initialDrinksAmount;
@synthesize coins=_coins;

-(id)init:(MoneyAmount*) newCoins : (DrinksContainer*) newDrinks
{
    self = [super init];
    if (self) {
        _coins=newCoins;
        currentDrinksAmount=newDrinks;
        initialDrinksAmount=[[DrinksContainer alloc]init ];
        NSMutableArray* currentDrinks=[[NSMutableArray alloc]initWithArray:[currentDrinksAmount getDrinks]];
        for(int i=0;i<[currentDrinks count];i++){
           // [initialDrinksAmount addDrink:<#(Drink *)#> quantity:<#(NSUInteger)#>:[currentDrinks objectAtIndex:i]];
        }
        [initialDrinksAmount commit];
        
    }
    return self;
}

-(DrinksContainer*)getCurrentDrinks
{
    return currentDrinksAmount;
}
-(DrinksContainer*)getInitialDrinks
{
    return initialDrinksAmount;
}

-(NSMutableDictionary*)getFiltratedDrinks
{
    NSMutableDictionary* currentDrinks=[[NSMutableDictionary alloc]initWithDictionary:currentDrinksAmount.drinks];
       
    for (Drink *storedDrink in [currentDrinks allKeys]) {
        if ([currentDrinks[storedDrink]integerValue] == 0) {
            [currentDrinks removeObjectForKey:storedDrink];
               }
    }

    
    
    return currentDrinks;
}
-(void)toFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"dataSource.plist"];
    
    
    NSString *error = [[NSString alloc]init];
    error = @" ERROR";
    NSData *mySerializedObject = [NSKeyedArchiver archivedDataWithRootObject:self.currentDrinksAmount];
    NSData *xmlData = [NSPropertyListSerialization dataFromPropertyList:mySerializedObject
                                                                 format:NSPropertyListXMLFormat_v1_0
                                                       errorDescription:&error];
    if( xmlData ) {
        [xmlData writeToFile:path atomically:YES];
    } else {
        NSLog(error);
        
    }
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.currentDrinksAmount forKey:@"drinksAmount"];
    [encoder encodeObject:self.coins forKey:@"coins"];
}

@end
