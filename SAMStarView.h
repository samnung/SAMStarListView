//
//  SAMStarView.h
//
//  Created by Roman Kříž on 02.06.13.
//  Copyright (c) 2013 samnung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAMStarView : UIView


@property (nonatomic, assign) BOOL full; // default YES
@property (nonatomic, assign) BOOL square; // default NO

@property (nonatomic, strong) UIColor * color;
@property (nonatomic, strong) UIColor * emptyColor; // default nil

@property (nonatomic, assign) CGFloat proportion; // default 0.38


- (id) initWithFrame:(CGRect)frame color:(UIColor *)color;


@end
