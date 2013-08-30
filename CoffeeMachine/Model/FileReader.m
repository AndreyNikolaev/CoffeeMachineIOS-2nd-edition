//
//  FileReader.m
//  CoffeeMachine
//
//  Created by dancho on 8/30/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "FileReader.h"

@implementation FileReader
@synthesize filePath;
-(NSDictionary*)getDictAtIndex:(int) index
{
    NSString* sourcePath = [[NSBundle mainBundle] pathForResource:filePath ofType:@"plist"];
    NSArray* sourceDataArray = [[NSArray alloc]initWithContentsOfFile:sourcePath];
    return [sourceDataArray objectAtIndex:index];
}

@end
