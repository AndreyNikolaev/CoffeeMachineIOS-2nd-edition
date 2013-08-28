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

@interface MoneyAmount : NSObject<NSCopying>

@property(strong)NSMutableDictionary *coins ;


-(MoneyAmount *)add:(Coin*) c : (int) count;
-(MoneyAmount *)add:(MoneyAmount*)mAmount;
-(Withdraw *)withdraw:(int)amount;
-(NSMutableArray *)getSortedCoinTypes;
-(void)getCoins:(Coin *)c : (int)count;
-(NSString *)description;
-(int)sumOfCoins;
- (void)addCoin:(Coin *)coin amount:(NSUInteger)amount;
-(void)setSomeCoins;
-(NSMutableArray *)coinsAmountToString;

@end
