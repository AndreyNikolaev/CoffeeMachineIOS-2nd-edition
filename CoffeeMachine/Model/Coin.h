//
//  Coin.h
//  PickerViewTest
//
//  Created by dancho on 8/7/13.
//  Copyright (c) 2013 graci. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface Coin : NSObject<NSCopying>

@property int value;
- (NSComparisonResult)compare:(Coin *)otherObject;


@end