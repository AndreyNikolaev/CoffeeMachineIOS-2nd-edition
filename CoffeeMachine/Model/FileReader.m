//
//  FileReader.m
//  CoffeeMachine
//
//  Created by dancho on 8/30/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "FileReader.h"

@implementation FileReader

- (id)initWithFileName:(NSString *)filename
{
    self = [super init];
    if (self) {
        self.fileName = filename;
    }
    return self;
}

-(NSDictionary*)getDictAtIndex:(int) index
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:_fileName];
    NSArray* sourceDataArray = [[NSArray alloc] initWithContentsOfFile:path];
    return [sourceDataArray objectAtIndex:index];
}

@end
