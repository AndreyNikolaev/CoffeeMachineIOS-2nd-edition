//
//  FileReader.m
//  CoffeeMachine
//
//  Created by dancho on 8/30/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "FileReader.h"

@implementation FileReader
@synthesize fileName;
-(NSDictionary*)getDictAtIndex:(int) index
{
   // NSString* sourcePath = [[NSBundle mainBundle] pathForResource:filePath ofType:@"plist"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSArray* sourceDataArray = [[NSArray alloc]initWithContentsOfFile:path];

    return [sourceDataArray objectAtIndex:index];
}

@end
