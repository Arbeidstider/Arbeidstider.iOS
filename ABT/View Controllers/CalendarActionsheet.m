//
//  CalendarActionsheet.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 18.10.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import "CalendarActionsheet.h"

@implementation CalendarActionsheet
-(id)initWithTitle:(NSString *)string{
    self = [super init];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CalendarActionsheet" owner:self options:nil];
        self = [nib objectAtIndex:0];
        CALayer *layer = self.layer;
        layer.shadowOffset = CGSizeMake(2, 2);
        layer.shadowColor = [[UIColor blackColor] CGColor];
        layer.shadowRadius = 4.0f;
        layer.shadowOpacity = 0.80f;
        layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];

        
          }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)cancelPressed:(id)sender{
    
    UIView *shadeView = [[UIView alloc]initWithFrame:self.cancel.bounds];
    shadeView.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:45.0/255.0 blue:48.0/255.0 alpha:0.5f];
    [self.cancel addSubview:shadeView];
    [self.delegate actionSheet:self selected:@"Cancel"];
}
-(void)yesPressed:(id)sender{
    UIView *shadeView = [[UIView alloc]initWithFrame:self.yes.bounds];
    shadeView.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:45.0/255.0 blue:48.0/255.0 alpha:0.5f];
    [self.yes addSubview:shadeView];

    [self.delegate actionSheet:self selected:@"Yes"];
}
-(void)maybePressed:(id)sender{
    UIView *shadeView = [[UIView alloc]initWithFrame:self.maybe.bounds];
    shadeView.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:45.0/255.0 blue:48.0/255.0 alpha:0.5f];
    [self.maybe addSubview:shadeView];

    
    [self.delegate actionSheet:self selected:@"Maybe"];
}
-(void)noPressed:(id)sender{
    UIView *shadeView = [[UIView alloc]initWithFrame:self.no.bounds];
    shadeView.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:45.0/255.0 blue:48.0/255.0 alpha:0.5f];
    [self.no addSubview:shadeView];

    [self.delegate actionSheet:self selected:@"No"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
