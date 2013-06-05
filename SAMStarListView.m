//
//  SAMStarListView.m
//
//  Created by Roman Kříž on 02.06.13.
//  Copyright (c) 2013 samnung. All rights reserved.
//

#import "SAMStarListView.h"
#import "SAMStarView.h"


static BOOL _defaultSquare = YES;
static CGFloat _defaultProportion = 0.38;

static NSUInteger _defaultCount = 5;
static NSUInteger _defaultCountOfFull = 0;

static UIColor * _defaultStrokeColor = nil;
static UIColor * _defaultEmptyColor = nil;

#define kDefaultStrokeColor [UIColor yellowColor]


@implementation SAMStarListView

// -------------------------------------------

+ (void) setDefaultSquare:(BOOL)sqaure
{
	_defaultSquare = sqaure;
}

+ (void) setDefaultProportion:(CGFloat)proportion
{
	_defaultProportion = proportion;
}

+ (void) setDefaultCount:(NSUInteger)count
{
	_defaultCount = count;
}
+ (void) setDefaultCountOfFull:(NSUInteger)countOfFull
{
	_defaultCountOfFull = countOfFull;
}

+ (void) setDefaultStrokeColor:(UIColor *)color
{
	if ( color )
		_defaultStrokeColor = color;
	else
		_defaultStrokeColor = kDefaultStrokeColor;
}
+ (void) setDefaultEmptyColor:(UIColor *)color
{
	_defaultEmptyColor = color;
}




// ---------------------------------------------

@synthesize count = _count, countOfFull = _countOfFull, square = _square, strokeColor = _strokeColor, emptyColor = _emptyColor, proportion = _proportion;


- (void) myInit
{
	_emptyColor = _defaultEmptyColor;
	_proportion = _defaultProportion;
	_square = _defaultSquare;

	_count = _defaultCount;
	_countOfFull = _defaultCountOfFull;
	
	if ( ! _defaultStrokeColor ) _defaultStrokeColor = kDefaultStrokeColor;
	
	_strokeColor = _defaultStrokeColor;
}

- (id) initWithFrame:(CGRect)frame count:(NSUInteger)count countOfFull:(NSUInteger)countOfFull withStrokeColor:(UIColor *)strokeColor
{
	self = [super initWithFrame:frame];
	
	if ( self )
	{
		[self myInit];
		
		_count = count;
		_countOfFull = countOfFull;
		_strokeColor = strokeColor;
		
		[self updateStars];
	}
	
	return self;
}

- (id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if ( self )
	{
		[self myInit];
		[self updateStars];
	}
	
	return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	
	if ( self )
	{
		[self myInit];
		[self updateStars];
	}
	
	return self;
}

- (void) setSquare:(BOOL)square
{
	_square = square;
	[self updateStarsProperties];
}

- (void) setCountOfFull:(NSUInteger)countOfFull
{
	_countOfFull = countOfFull;
	[self updateStarsProperties];
}

- (void) setStrokeColor:(UIColor *)strokeColor
{
	if ( strokeColor )
		_strokeColor = strokeColor;
	else
		_strokeColor = kDefaultStrokeColor;
	
	[self updateStarsProperties];
}

- (void) setEmptyColor:(UIColor *)emptyColor
{
	_emptyColor = emptyColor;
	[self updateStarsProperties];
}

- (void) setProportion:(CGFloat)proportion
{
	_proportion = proportion;
	[self updateStarsProperties];
}

- (void) setCount:(NSUInteger)count
{
	_count = count;
	
	[self updateStars];
}


- (void) updateStars
{
	[self removeAllSubviews];
	
	for (NSUInteger i = 0; i < _count; i++ )
	{
		CGFloat width = self.bounds.size.width / _count;
		CGFloat x = i * width;
		CGRect rect = CGRectMake(x, 0, width, self.bounds.size.height);
		SAMStarView *star = [[SAMStarView alloc] initWithFrame:rect color:_strokeColor];
		[self addSubview:star];
	}
	
	[self updateStarsProperties];
}

- (void) updateStarsProperties
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
	return (( point.x / self.bounds.size.width ) * _count) + 0.75;
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
