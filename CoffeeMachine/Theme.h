//
//  Theme.h
//  CoffeeMachine
//
//  Created by dancho on 10/3/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Theme : NSObject
+ (Theme *)sharedTheme;

- (UIFont *)coffeeFontWithSize:(CGFloat)size;
-(UIColor *)lblBackColor;
-(UIImage *) backGroudImage;
@end
