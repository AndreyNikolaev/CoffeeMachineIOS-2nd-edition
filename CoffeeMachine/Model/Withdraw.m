

//
//  Withdraw.m
//  CoffeeX
//
//  Created by System Administrator on 8/12/13.
//  Copyright (c) 2013 System Administrator. All rights reserved.
//

#import "Withdraw.h"
#import "MoneyAmount.h"

@implementation Withdraw

-(id)init
{
    self = [super init];
    if (self) {
        _status = SUCCESSFUL;
        _change = [[MoneyAmount alloc] init];
    }
    return self;
}

-(Withdraw *) statusAndChange:(WithdrawRequestResultStatus) newStatus : (MoneyAmount *)newChange
{
    _status  = newStatus;
    _change = newChange;
    return self;
}

@end
