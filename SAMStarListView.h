//
//  SAMStarListView.h
//
//  Created by Roman Kříž on 02.06.13.
//  Copyright (c) 2013 samnung. All rights reserved.
//


@interface SAMStarListView : UIView


@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSUInteger countOfFull;

@property (nonatomic, assign) BOOL square;

@property (nonatomic, strong) UIColor * strokeColor;
@property (nonatomic, strong) UIColor * emptyColor;

@property (nonatomic, assign) CGFloat proportion; // default 0.38


- (id) initWithFrame:(CGRect)frame count:(NSUInteger)count countOfFull:(NSUInteger)countOfFull withStrokeColor:(UIColor *)strokeColor;


@end
