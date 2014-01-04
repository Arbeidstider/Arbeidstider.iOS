//
//  TimeLineView.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 03.12.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import "TimeLineView.h"

#define kHoursInDay 24 //Hours
#define kLengthOfHour 100 //Pixels

@implementation TimeLineView

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    self = [super initWithFrame:frame];
    if (self) {
        self.data = @[
                      @{@"start": @"7:15",@"end":@"15:00"},
                      @{@"start": @"8:00",@"end":@"16:45"},
                      @{@"start": @"10:00",@"end":@"15:00"},
                      @{@"start": @"17:10",@"end":@"23:00"},
                      @{@"start": @"16:00",@"end":@"22:00"}];
    }
    
    return self;
}
- (void)setTransform:(CGAffineTransform)newValue;
{
    CGAffineTransform constrainedTransform = CGAffineTransformIdentity;
    constrainedTransform.a = newValue.a;
    [super setTransform:constrainedTransform];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIScrollView*scrollView = (UIScrollView*)self.superview;
    float zoom = scrollView.zoomScale;
    zoom = 1;
    UIColor* fillColor = [UIColor whiteColor];
    CGRect bounds = [self bounds];
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:bounds];
    [fillColor setFill];
    [rectanglePath fill];

    
    //Draw Seperators
    for (int i = 0; i<=kHoursInDay; i++) {
        UIColor *hourColor = [UIColor blackColor];
    
        UIBezierPath *hourSeperator = [UIBezierPath bezierPath];
        [hourSeperator moveToPoint:CGPointMake(i*kLengthOfHour, 0)];
        [hourSeperator addLineToPoint:CGPointMake(i*kLengthOfHour, scrollView.frame.size.height)];
        [hourColor setStroke];
        hourSeperator.lineWidth = 1;
        [hourSeperator stroke];
        
        
        UIColor *halfHourColor = [UIColor darkGrayColor];
        UIBezierPath *halfHoursSeparator = [UIBezierPath bezierPath];
        [halfHoursSeparator moveToPoint:CGPointMake(i*kLengthOfHour+kLengthOfHour/2, 0)];
        [halfHoursSeparator addLineToPoint:CGPointMake(i*kLengthOfHour+kLengthOfHour/2, scrollView.frame.size.height)];
        [halfHourColor setStroke];
        halfHoursSeparator.lineWidth = (CGFloat)0.5f;
        [halfHoursSeparator stroke];
        
        for (int q = kLengthOfHour/4; q<kLengthOfHour; q+=(kLengthOfHour/4)*2) {
            UIColor *quarterColor = [UIColor lightGrayColor];
            UIBezierPath *querterSeperator = [UIBezierPath bezierPath];
            [querterSeperator moveToPoint:CGPointMake(i*kLengthOfHour+q, 0)];
            [querterSeperator addLineToPoint:CGPointMake(i*kLengthOfHour+q, scrollView.frame.size.height)];
            [quarterColor setStroke];
            querterSeperator.lineWidth = (CGFloat)0.5f;
            [querterSeperator stroke];
        }
        
    }
    
    //Draw Shits
    int i = 0;
    for (NSDictionary *shift in self.data) {
        NSString *start = [shift objectForKey:@"start"];
        NSString *end = [shift objectForKey:@"end"];
    
        float startHour = [[start componentsSeparatedByString:@":"].firstObject floatValue];
        float startMinute = [[start componentsSeparatedByString:@":"].lastObject floatValue];

        float endHour = [[end componentsSeparatedByString:@":"].firstObject floatValue];
        float endMinute = [[end componentsSeparatedByString:@":"].lastObject floatValue];

        
        CGFloat startOfShiftPixel = startHour*kLengthOfHour+startMinute*(kLengthOfHour/60);
        CGFloat endOfShiftPixel = endHour*kLengthOfHour+endMinute*(kLengthOfHour/60);
        
        NSLog(@"%f, %f",startOfShiftPixel,endOfShiftPixel);
        
        UIBezierPath *shiftRect = [UIBezierPath bezierPathWithRect:CGRectMake(startOfShiftPixel, i, endOfShiftPixel-startOfShiftPixel, 50)];
        UIColor* fillColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        UIColor* strokeColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];

        [fillColor setFill];
        [shiftRect fill];
        [strokeColor setStroke];
        shiftRect.lineWidth = 1;
        [shiftRect stroke];
        i += 50;
    }
    
    
}
-(void)setContentScaleFactor:(CGFloat)contentScaleFactor{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
}
@end
