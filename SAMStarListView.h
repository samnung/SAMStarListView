//
//  SAMStarListView.h
//
//  Created by Roman Kříž on 02.06.13.
//  Copyright (c) 2013 samnung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAMStarListView : UIView


@property (nonatomic, assign) NSUInteger count; // default 5
@property (nonatomic, assign) NSUInteger countOfSelected; // default 0

@property (nonatomic, assign) BOOL square; // default YES

@property (nonatomic, strong) UIColor * strokeColor;
@property (nonatomic, strong) UIColor * emptyColor;

@property (nonatomic, assign) CGFloat proportion; // default 0.38


- (id) initWithFrame:(CGRect)frame count:(NSUInteger)count countOfSelected:(NSUInteger)countOfSelected withStrokeColor:(UIColor *)strokeColor;



+ (void) setDefaultSquare:(BOOL)sqaure;

+ (void) setDefaultProportion:(CGFloat)proportion;

+ (void) setDefaultCount:(NSUInteger)count;
+ (void) setDefaultCountOfSelected:(NSUInteger)countOfSelected;

+ (void) setDefaultStrokeColor:(UIColor *)color;
+ (void) setDefaultEmptyColor:(UIColor *)color;


@end
