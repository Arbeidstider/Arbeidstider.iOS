//
//  TimeLineView.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 03.12.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import "TimeLineView.h"

@implementation TimeLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)setTransform:(CGAffineTransform)newValue;
{
    newValue.d = 1.0;
    [super setTransform:newValue];
}
-(void)redrawContentWithScale:(float)scale{
    [self drawRect:[self bounds]];

    
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"drawRect %s",__PRETTY_FUNCTION__);
    [super drawRect:rect];
    double zoom = self.zoomScale;
    //CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];
    //// Color Declarations
    UIColor* fillColor = [UIColor lightGrayColor];
    UIColor* strokeColor = [UIColor blackColor];
    if (zoom > 2) {
        fillColor = [UIColor redColor];
    }
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:bounds];
    [fillColor setFill];
    [rectanglePath fill];
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(zoom*25+25, 0)];
    [bezierPath addLineToPoint: CGPointMake(zoom*25+25, bounds.size.height)];
    [strokeColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(zoom*25+50, 0)];
    [bezier2Path addLineToPoint: CGPointMake(zoom*25+50, bounds.size.height)];
    [strokeColor setStroke];
    bezier2Path.lineWidth = 1;
    [bezier2Path stroke];
    
    
    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(zoom*25+75, 0)];
    [bezier3Path addLineToPoint: CGPointMake(zoom*25+75, bounds.size.height)];
    [strokeColor setStroke];
    bezier3Path.lineWidth = 1;
    [bezier3Path stroke];
    
    
    //// Bezier 4 Drawing
    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path moveToPoint: CGPointMake(zoom*25+100, 0)];
    [bezier4Path addLineToPoint:  CGPointMake(zoom*25+100, bounds.size.height)];
    [strokeColor setStroke];
    bezier4Path.lineWidth = 1;
    [bezier4Path stroke];

}
+(TimeLineView *)sharedDrawView{
    static TimeLineView *sharedDrawView;
    if(!sharedDrawView) sharedDrawView = [[TimeLineView alloc] initWithFrame:CGRectMake(0, 0, 10000, 438)];
    return sharedDrawView;
}

@end
