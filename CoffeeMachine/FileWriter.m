//
//  FileWriter.m
//  CoffeeMachine
//
//  Created by dancho on 9/3/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "FileWriter.h"

@implementation FileWriter

- (id)initWithFileName:(NSString *)filename
{
    self = [super init];
    if (self) {
        self.fileName = filename;
    }
    return self;
}

-(void)saveToPlist:(NSArray *)arrayToSave
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:self.fileName];
    [arrayToSave writeToFile:path atomically:YES];
}
@end
