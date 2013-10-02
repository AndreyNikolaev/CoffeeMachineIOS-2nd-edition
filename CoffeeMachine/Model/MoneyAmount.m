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
       self.coins=[[NSMutableDictionary alloc] init];
    }
    return self;
}

//adding a coin into coins dictionary
-(MoneyAmount *)add:(Coin *)coin : (int)count
{
    [self.coins setObject:[NSNumber numberWithInteger:count] forKey:coin];
    return self;
}

//adding a coin 
- (void)addCoinForFromPlist:(Coin *)coin amount:(NSUInteger)amount
{
    BOOL coinFound = NO;
    for (Coin *storedCoin in [self.coins allKeys]) {
        if ([storedCoin isEqual:coin]) {
            coinFound = YES;
            [self.coins setObject:@(amount ) forKey:storedCoin];
            break;
        }
    }
    if (!coinFound) {
        [self.coins setObject:@(amount) forKey:coin];
    }
}

// adding a MoneyAmount into coins dictionary
-(MoneyAmount *)add:(MoneyAmount*)mAmount
{
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

//adding a coin and its amount
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

// sorting all coins in desc order
-(NSArray*)sortedCoinTypes
{
    NSArray *availableCoinTypes = [[NSArray alloc] initWithArray:[coins allKeys]];
    availableCoinTypes = [availableCoinTypes sortedArrayUsingSelector:@selector(compare:)];
    availableCoinTypes = [[availableCoinTypes reverseObjectEnumerator] allObjects];
    return availableCoinTypes;
}

-(Withdraw *)withdraw:(int)amount
{
    MoneyAmount *requestedCoins = [[MoneyAmount alloc] init];
    if (amount == 0) {
        WithdrawRequestResultStatus req = SUCCESSFUL;
        Withdraw *withdraw = [[Withdraw alloc] init] ;
        [ withdraw statusAndChange:req : requestedCoins];
        return withdraw;
    }
    Coin* coin = [[Coin alloc] init];
    NSArray* sortedCoins = [[NSArray alloc] init];
    sortedCoins = [self sortedCoinTypes];
    int totalAvailFromThisType = -1;
    int possibleCoinsToGet = -1;
    for(int i = 0;i < [sortedCoins count];i ++){
        coin = [sortedCoins objectAtIndex:i];
        if (amount >0 && (amount - coin.value >= 0)){
            possibleCoinsToGet = amount / coin.value;
             totalAvailFromThisType = [self.coins[coin] intValue];
               if (totalAvailFromThisType >= possibleCoinsToGet) {
                [requestedCoins add:coin :possibleCoinsToGet];
                [self outCoins:coin :possibleCoinsToGet];
                amount -= coin.value*possibleCoinsToGet;
            } else if(totalAvailFromThisType < possibleCoinsToGet){
                [requestedCoins add:coin :totalAvailFromThisType];
                [self outCoins:coin :totalAvailFromThisType];
                amount -= coin.value * totalAvailFromThisType;
            }
        }
    }        
    if (amount == 0) {
        Withdraw* withdraw = [[Withdraw alloc] init];
        withdraw = [withdraw statusAndChange:SUCCESSFUL:requestedCoins ];
        return withdraw;
    }
    Withdraw* withdraw = [[Withdraw alloc] init];
    withdraw = [withdraw statusAndChange:INSUFFICIENT_AMOUNT:requestedCoins ];
    return withdraw;
}

-(void)outCoins:(Coin *)coin :(int)count
{
    int availableCoins=[self.coins[coin] intValue];
    if(availableCoins >= count){
        int totalCount = availableCoins - count;
        [self.coins setObject:[NSNumber numberWithInteger:totalCount] forKey:(id)coin];
    }
}

// accumulate sum of coins 
-(int)sumOfCoins
{
    int amount=0;
    for (Coin *coin in [self.coins allKeys]) {
        amount+=coin.value*[self.coins[coin] integerValue];
    }
    return amount;
}

// get coins amount as string
-(NSMutableArray *)coinsAmountToString
{
    NSMutableArray* coinsAmount=[[NSMutableArray alloc]init];
    for (Coin *coin in [self.coins allKeys]) {
        [coinsAmount addObject:[NSString stringWithFormat:@"%d - amount: %d",coin.value,[self.coins[coin]integerValue]]];
    }
    return coinsAmount;
}


-(void)loadCoinsFromPlist
{
    FileReader* file = [[FileReader alloc] init];
    file.fileName = @"writedFile.plist";
    int i = 0;
    Coin  *coin = [[Coin alloc] init];
    NSDictionary *dictCoins = [[NSDictionary alloc] initWithDictionary:[file getDictAtIndex:2]];
    NSArray* amounts = [[NSArray alloc]initWithArray:[dictCoins allValues]];
    for(NSString *currentCoin in [dictCoins allKeys])
    {
        coin.value = currentCoin.integerValue;
        [self addCoinForFromPlist:coin amount:[[amounts objectAtIndex:i] integerValue]];
        i++;
    }
}

// get coins and their amounts 
-(NSMutableDictionary *)coinsValueAndAmount
{
    NSMutableDictionary* coinsValueAndAmount = [[NSMutableDictionary alloc]init];
    for(Coin *coin in [self.coins allKeys]){
        [coinsValueAndAmount setObject:[NSNumber numberWithInteger:[self.coins[coin]integerValue]]forKey:[NSString stringWithFormat:@"%d",coin.value]];
    }
    return coinsValueAndAmount;
}
@end
