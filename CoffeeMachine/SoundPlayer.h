//
//  SoundPlayer.h
//  CoffeeMachine
//
//  Created by dancho on 9/19/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundPlayer : NSObject
@property NSString* fileName;
@property NSString* fileType;

-(void)play:(NSString*) fileName : (NSString*) fileType;
@end
