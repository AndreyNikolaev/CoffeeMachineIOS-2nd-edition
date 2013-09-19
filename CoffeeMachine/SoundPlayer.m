//
//  SoundPlayer.m
//  CoffeeMachine
//
//  Created by dancho on 9/19/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "SoundPlayer.h"

@implementation SoundPlayer
@synthesize fileName;
@synthesize fileType;

-(void)play:(NSString*) fileName : (NSString*) fileType
{
	SystemSoundID SoundID;
	NSString *soundFile = [[NSBundle mainBundle] pathForResource: self.fileName ofType:self.fileType];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:soundFile], &SoundID);
	AudioServicesPlaySystemSound(SoundID);
}
@end
