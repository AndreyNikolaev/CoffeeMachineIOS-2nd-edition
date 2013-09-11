

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
        status=SUCCESSFUL;
        change=[[MoneyAmount alloc]init];
        
    }
    return self;
}

@synthesize status;
@synthesize change;
-(Withdraw *) StatusAndChange:(WithdrawRequestResultStatus) newStatus : (MoneyAmount *)newChange {
    status  = newStatus;
    change = newChange;
    return self;
}


@end
