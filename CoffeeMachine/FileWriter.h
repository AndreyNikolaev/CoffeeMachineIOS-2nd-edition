//
//  FileWriter.h
//  CoffeeMachine
//
//  Created by dancho on 9/3/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileWriter : NSObject

@property(strong) NSString *fileName;

- (id)initWithFileName:(NSString *)filename;
-(void)saveToPlist : (NSArray *)arrayToSave ;

@end
