//
//  MoneyAmount.m
//  PickerViewTest
//
//  Created by dancho on 8/12/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "MoneyAmount.h"
#import "Coin.h"
#import "Withdraw.h"
#import "Drink.h"
#import "FileReader.h"

@implementation MoneyAmount

@synthesize coins;
-(id)init
{
    self = [super init];
    if (self) {
       self.coins=[[NSMutableDictionary alloc]init];
    }
    return self;
}




-(MoneyAmount *)add:(Coin *)c : (int)count {
    [self.coins setObject:[NSNumber numberWithInteger:count] forKey:c];
    return self;

}
-(MoneyAmount *)add:(MoneyAmount*)mAmount {
    for(Coin* coin in [self.coins allKeys]){
        for (Coin *updatedCoin in [mAmount.coins allKeys]) {
            if ([updatedCoin isEqual:coin]) {
                [self.coins setObject:@([mAmount.coins[updatedCoin] integerValue] + [self.coins[updatedCoin] intValue]) forKey:updatedCoin];
                break;
            }
        }
    }
    return self;
}


- (void)addCoin:(Coin *)coin amount:(NSUInteger)amount
{
    BOOL coinFound = NO;
    for (Coin *storedCoin in [self.coins allKeys]) {
        if ([storedCoin isEqual:coin]) {
            coinFound = YES;
            [self.coins setObject:@(amount + [self.coins[storedCoin] integerValue]) forKey:storedCoin];
            break;
        }
    }
    
    if (!coinFound) {
        [self.coins setObject:@(amount) forKey:coin];
    }
}



-(NSMutableArray*)getSortedCoinTypes{
    
    NSMutableArray *availableCoinTypes = [[NSMutableArray alloc]initWithArray:[coins allKeys]];
    availableCoinTypes=[availableCoinTypes sortedArrayUsingSelector:@selector(compare:)];
    availableCoinTypes=[[availableCoinTypes reverseObjectEnumerator] allObjects];
    NSLog(@"Sorted Array: %@", [availableCoinTypes description]);
    return availableCoinTypes;

}

-(Withdraw *)withdraw:(int)amount {
    MoneyAmount *requestedCoins = [[MoneyAmount alloc]init];
    
    if (amount == 0) {
        WithdrawRequestResultStatus req = SUCCESSFUL;
        Withdraw *withdraw = [[Withdraw alloc]init] ;
        [ withdraw StatusAndChange:req : requestedCoins];
        return withdraw;
    }
    Coin* coin=[[Coin alloc]init];
    NSArray* sortedCoins=[[NSArray alloc]init];
    sortedCoins=[self getSortedCoinTypes];
    int totalAvailFromThisType = -1;
    int possibleCoinsToGet =-1;
    for(int i=0;i<[sortedCoins count];i++){
        coin=[sortedCoins objectAtIndex:i];
        if (amount >0 && (amount - coin.value >= 0)){
            possibleCoinsToGet = amount / coin.value;
             totalAvailFromThisType = [self.coins[coin] intValue];
        
            if (totalAvailFromThisType >= possibleCoinsToGet) {
                [requestedCoins add:coin :possibleCoinsToGet];
                [self getCoins:coin :possibleCoinsToGet];
                amount-=coin.value*possibleCoinsToGet;
                
            } else if(totalAvailFromThisType < possibleCoinsToGet){
                [requestedCoins add:coin :totalAvailFromThisType];
                [self getCoins:coin :totalAvailFromThisType];
                amount -= coin.value * totalAvailFromThisType;
            }
        }
        
    }
        
    if (amount==0) {
        Withdraw* withdraw=[[Withdraw alloc]init];
        withdraw=[withdraw StatusAndChange:SUCCESSFUL:requestedCoins ];
        return withdraw;
    }
    Withdraw* withdraw=[[Withdraw alloc]init];
    withdraw=[withdraw StatusAndChange:INSUFFICIENT_AMOUNT:requestedCoins ];
    return withdraw;
    
}
-(void)getCoins:(Coin *)coin :(int)count{
    int availableCoins=[self.coins[coin] intValue];
    if(availableCoins >= count){
        int totalCount = availableCoins - count;
        [self.coins setObject:[NSNumber numberWithInteger:totalCount] forKey:(id)coin];
    }
}

-(NSString*)description { 
    NSString* stringCoins=[[NSString alloc]init];
    for(Coin *coin in [self.coins allKeys]){
         stringCoins=[stringCoins stringByAppendingString:[NSString stringWithFormat:@"%dst X %d ",coin.value, [self.coins[coin] intValue]]];
    }
    NSLog(@"description: %@",stringCoins);
       return stringCoins;
}

-(int)sumOfCoins
{
   int amount=0;
    for (Coin *coin in [self.coins allKeys]) {

amount+=coin.value*[self.coins[coin] integerValue];
    }
    return amount;
}


-(NSMutableArray *)coinsAmountToString {
    NSMutableArray* coinsAmount=[[NSMutableArray alloc]init];
    for (Coin *coin in [self.coins allKeys]) {
        [coinsAmount addObject:[NSString stringWithFormat:@"%d - amount: %d",coin.value,[self.coins[coin]integerValue]]];
    }
    return coinsAmount;
}


-(void)loadCoinsFromPlist
{
    FileReader* file = [[FileReader alloc]init];
    file.fileName = @"writedFile.plist";
    int i=0;
    Coin  *coin=[[Coin alloc]init];
    NSDictionary *dictCoins = [[NSDictionary alloc] initWithDictionary:[file getDictAtIndex:2]];
    NSArray* amounts=[[NSArray alloc]initWithArray:[dictCoins allValues]];
    for(NSString *currentCoin in [dictCoins allKeys])
    {
        coin.value = currentCoin.integerValue;
        [self addCoin:coin amount:[[amounts objectAtIndex:i] integerValue]];
        i++;
    }
    
}
-(NSMutableDictionary *)coinsValueAndAmount {
    NSMutableDictionary* coinsValueAndAmount = [[NSMutableDictionary alloc]init];
    for(Coin *coin in [self.coins allKeys]){
        [coinsValueAndAmount setObject:[NSNumber numberWithInteger:[self.coins[coin]integerValue]]forKey:[NSString stringWithFormat:@"%d",coin.value]];
    }
    return coinsValueAndAmount;
}
@end
