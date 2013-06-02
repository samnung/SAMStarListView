//
//  SAMStarView.h
//
//  Created by Roman Kříž on 02.06.13.
//  Copyright (c) 2013 samnung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAMStarView : UIView


@property (nonatomic, assign) BOOL full;
@property (nonatomic, assign) BOOL square;
@property (nonatomic, strong) UIColor * color;


- (id) initWithFrame:(CGRect)frame color:(UIColor *)color;


@end
