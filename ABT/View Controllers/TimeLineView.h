//
//  TimeLineView.h
//  Arbeidstider
//
//  Created by Oscar Apeland on 03.12.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLineView : UIView
+(TimeLineView *)sharedDrawView;
@property (nonatomic) double zoomScale;
-(void)redrawContentWithScale:(float)scale;
@end
