//
//  Withdraw.h
//  CoffeeX
//
//  Created by System Administrator on 8/12/13.
//  Copyright (c) 2013 System Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoneyAmount.h"

typedef enum
{
    SUCCESSFUL,
    INSUFFICIENT_AMOUNT
} WithdrawRequestResultStatus;

@interface Withdraw : NSObject

@property WithdrawRequestResultStatus status;
@property MoneyAmount *change;

-(Withdraw *) StatusAndChange:(WithdrawRequestResultStatus) status : (MoneyAmount *)change;
@end
