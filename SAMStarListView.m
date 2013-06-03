//
//  SAMStarListView.m
//
//  Created by Roman Kříž on 02.06.13.
//  Copyright (c) 2013 samnung. All rights reserved.
//

#import "SAMStarListView.h"
#import "SAMStarView.h"


@implementation SAMStarListView

@synthesize count = _count, countOfFull = _countOfFull, square = _square, strokeColor = _strokeColor, emptyColor = _emptyColor, proportion = _proportion;


- (id) initWithFrame:(CGRect)frame count:(NSUInteger)count countOfFull:(NSUInteger)countOfFull withStrokeColor:(UIColor *)strokeColor
{
	self = [super initWithFrame:frame];
	
	if ( self )
	{
		_count = count;
		_countOfFull = countOfFull;
		_strokeColor = strokeColor;
		_emptyColor = nil;
		_proportion = 0.38;
		
		for (NSUInteger i = 0; i < _count; i ++)
		{
			CGFloat width = self.bounds.size.width / _count;
			CGFloat x = i * width;
			CGRect rect = CGRectMake(x, 0, width, self.bounds.size.height);
			SAMStarView *star = [[SAMStarView alloc] initWithFrame:rect color:_strokeColor];
			star.full = !(i+1 > _countOfFull);
			star.proportion = _proportion;
			star.emptyColor = _emptyColor;
			[self addSubview:star];
		}
	}
	
	return self;
}

- (void) setSquare:(BOOL)square
{
	_square = square;
	[self updateStars];
}

- (void) setCountOfFull:(NSUInteger)countOfFull
{
	_countOfFull = countOfFull;
	[self updateStars];
}

- (void) setStrokeColor:(UIColor *)strokeColor
{
	_strokeColor = strokeColor;
	[self updateStars];
}

- (void) setEmptyColor:(UIColor *)emptyColor
{
	_emptyColor = emptyColor;
	[self updateStars];
}

- (void) setProportion:(CGFloat)proportion
{
	_proportion = proportion;
	[self updateStars];
}

- (void) updateStars
{
	NSUInteger i = 0;
	
	for ( UIView * view in self.subviews )
	{
		if ( [view isMemberOfClass:[SAMStarView class]] )
		{
			SAMStarView *star = (SAMStarView *)view;
			star.proportion = _proportion;
			star.emptyColor = _emptyColor;
			star.color = _strokeColor;
			star.square = _square;
			
			star.full = !(i+1 > _countOfFull);
			
			i++;
		}
	}
}

- (void) layoutSubviews
{
	NSUInteger i = 0;
	
	CGFloat width = self.frame.size.width / _count;
	CGFloat height = self.frame.size.height;
	
	for ( UIView * view in self.subviews )
	{
		if ( [view isMemberOfClass:[SAMStarView class]] )
		{
			view.frame = CGRectMake(i * width, 0.0, width, height);
			i++;
		}
	}
}

- (NSUInteger) numberOfStarAtPoint:(CGPoint)point
{
	return (( point.x / self.bounds.size.width ) * _count) + 0.5;
}

- (void) handleTouches:(NSSet *)touches
{
	if ( touches.count == 1 )
	{
		UITouch *touch = [touches anyObject];
		CGPoint point = [touch locationInView:self];
		
		self.countOfFull = [self numberOfStarAtPoint:point];
	}
}



- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self handleTouches:touches];
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self handleTouches:touches];
}


@end
