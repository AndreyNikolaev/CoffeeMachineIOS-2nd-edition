//
//  DraggableImageView.m
//  CoffeeMachine
//
//  Created by dancho on 9/11/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "DraggableImageView.h"

@implementation DraggableImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.copied = [[DraggableImageView alloc] initWithImage:[self image]];
    
   // [self.copied setDelegate:[self delegate]];
    [self.copied setFrame:[self frame]];
    
    [[self superview] addSubview:self.copied];
    
    CGPoint pt = [[touches anyObject] locationInView:self.copied];
    
    self.copied.startLocation = pt;
    
    [[self.copied superview] bringSubviewToFront:self.copied];
}
@end