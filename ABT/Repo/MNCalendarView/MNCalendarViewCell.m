//
//  MNCalendarViewCell.m
//  MNCalendarView
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNCalendarViewCell.h"

void MNContextDrawLine(CGContextRef c, CGPoint start, CGPoint end, CGColorRef color, CGFloat lineWidth) {
  CGContextSetAllowsAntialiasing(c, false);
  CGContextSetStrokeColorWithColor(c, color);
  CGContextSetLineWidth(c, lineWidth);
  CGContextMoveToPoint(c, start.x, start.y - (lineWidth/2.f));
  CGContextAddLineToPoint(c, end.x, end.y - (lineWidth/2.f));
  CGContextStrokePath(c);
  CGContextSetAllowsAntialiasing(c, true);
}

NSString *const MNCalendarViewCellIdentifier = @"MNCalendarViewCellIdentifier";

@interface MNCalendarViewCell()

@property(nonatomic,strong,readwrite) UILabel *titleLabel;

@end

@implementation MNCalendarViewCell


-(UIView *)circleWithColor:(UIColor *)color radius:(int)radius {
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * radius, 2 * radius)];
    circle.backgroundColor = color;
    circle.layer.cornerRadius = radius;
    circle.layer.masksToBounds = YES;
    return circle;
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.whiteColor;
    self.contentView.backgroundColor = UIColor.clearColor;
      self.dotView = [self circleWithColor:[UIColor clearColor] radius:3.5f];
      self.dotView.center = CGPointMake(self.bounds.size.width/2, 5);
    [self addSubview:self.dotView];
    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.titleLabel.textColor = [UIColor darkTextColor];
    self.titleLabel.highlightedTextColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.userInteractionEnabled = NO;
    self.titleLabel.backgroundColor = [UIColor clearColor];
      
    [self.contentView addSubview:self.titleLabel];
    
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.23f green:0.61f blue:1.f alpha:1.f];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  self.contentView.frame = self.bounds;
  self.selectedBackgroundView.frame = self.bounds;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGColorRef separatorColor = self.separatorColor.CGColor;
  
  CGFloat pixel = 1.f / [UIScreen mainScreen].scale;
  MNContextDrawLine(context,
                    CGPointMake(0.f, self.bounds.size.height),
                    CGPointMake(self.bounds.size.width, self.bounds.size.height),
                    separatorColor,
                    pixel);
}

@end
