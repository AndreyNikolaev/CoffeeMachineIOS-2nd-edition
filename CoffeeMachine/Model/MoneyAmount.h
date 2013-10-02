//
//  MoneyAmount.h
//  PickerViewTest
//
//  Created by dancho on 8/12/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coin.h"

@class Withdraw;

@interface MoneyAmount : NSObject

@property(strong)NSMutableDictionary *coins ;


-(MoneyAmount *)add:(Coin*) coin : (int) count;
-(MoneyAmount *)add:(MoneyAmount*)mAmount;
-(Withdraw *)withdraw:(int)amount;
-(NSArray *)sortedCoinTypes;
-(void)outCoins:(Coin *)coin : (int)count;
-(int)sumOfCoins;
- (void)addCoin:(Coin *)coin amount:(NSUInteger)amount;
-(NSMutableArray *)coinsAmountToString;
-(void)loadCoinsFromPlist;
-(NSMutableDictionary *)coinsValueAndAmount;
- (void)addCoinForFromPlist:(Coin *)coin amount:(NSUInteger)amount;

@end
