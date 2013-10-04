//
//  SoundPlayer.m
//  CoffeeMachine
//
//  Created by dancho on 9/19/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "SoundPlayer.h"

@implementation SoundPlayer

<<<<<<< HEAD
- (id)initWithFileName: (NSString *)theFileName andFileType: (NSString *) TheFileType
{
    self = [super init];
    if (self) {
        self.fileName = theFileName;
        self.fileType = TheFileType;
=======
- (id)initWithFileNameAndType:(NSString *)filename filetype : (NSString *)fileType
{
    self = [super init];
    if (self) {
        self.fileName = filename;
        self.fileType = fileType;
>>>>>>> 884ed34fb99eed0df139c201e5359f79c4d9ed9a
    }
    return self;
}

-(void)play
{
	SystemSoundID SoundID;
	NSString *soundFile = [[NSBundle mainBundle] pathForResource: self.fileName ofType:self.fileType];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:soundFile], &SoundID);
	AudioServicesPlaySystemSound(SoundID);
}

@end
