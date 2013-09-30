//
//  FileReader.h
//  CoffeeMachine
//
//  Created by dancho on 8/30/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileReader : NSObject

@property NSString* fileName;

- (id)initWithFileName:(NSString *)filename;
-(NSDictionary*)getDictAtIndex:(int) index;

@end
