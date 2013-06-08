//
//  SAMStarListView.m
//
//  Created by Roman Kříž on 02.06.13.
//  Copyright (c) 2013 samnung. All rights reserved.
//

#import "SAMStarListView.h"


static BOOL _defaultSquare = YES;
static CGFloat _defaultProportion = 0.38;

static NSUInteger _defaultCount = 5;
static NSUInteger _defaultCountOfSelected = 0;

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
+ (void) setDefaultCountOfSelected:(NSUInteger)countOfSelected
{
	_defaultCountOfSelected = countOfSelected;
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

@synthesize count = _count, countOfSelected = _countOfSelected, square = _square, strokeColor = _strokeColor, emptyColor = _emptyColor, proportion = _proportion;


- (void) myInit
{
	_emptyColor = _defaultEmptyColor;
	_proportion = _defaultProportion;
	_square = _defaultSquare;

	_count = _defaultCount;
	_countOfSelected = _defaultCountOfSelected;

	if ( ! _defaultStrokeColor ) _defaultStrokeColor = kDefaultStrokeColor;

	_strokeColor = _defaultStrokeColor;
}

- (id) initWithFrame:(CGRect)frame count:(NSUInteger)count countOfSelected:(NSUInteger)countOfSelected withStrokeColor:(UIColor *)strokeColor
{
	self = [super initWithFrame:frame];

	if ( self )
	{
		[self myInit];

		_count = count;
		_countOfSelected = countOfSelected;
		_strokeColor = strokeColor;
	}

	return self;
}

- (id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];

	if ( self )
	{
		[self myInit];
	}

	return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];

	if ( self )
	{
		[self myInit];
	}

	return self;
}


#pragma mark -
#pragma mark Getters / Setters

- (void) setSquare:(BOOL)square
{
	_square = square;
	[self setNeedsDisplay];
}
- (void) setCount:(NSUInteger)count
{
	_count = count;
	[self setNeedsDisplay];
}
- (void) setCountOfSelected:(NSUInteger)countOfSelected
{
	_countOfSelected = countOfSelected;
	[self setNeedsDisplay];
}
- (void) setStrokeColor:(UIColor *)strokeColor
{
	if ( strokeColor )
		_strokeColor = strokeColor;
	else
		_strokeColor = kDefaultStrokeColor;

	[self setNeedsDisplay];
}
- (void) setEmptyColor:(UIColor *)emptyColor
{
	_emptyColor = emptyColor;
	[self setNeedsDisplay];
}
- (void) setProportion:(CGFloat)proportion
{
	_proportion = proportion;
	[self setNeedsDisplay];
}



#pragma mark -
#pragma mark Touch

- (NSUInteger) numberOfStarAtPoint:(CGPoint)point
{
	return (( point.x / self.bounds.size.width ) * _count) + 0.75; // 0.75 == 1 - 0.25 treshold
}

- (void) handleTouches:(NSSet *)touches
{
	if ( touches.count == 1 )
	{
		UITouch *touch = [touches anyObject];
		CGPoint point = [touch locationInView:self];

		self.countOfSelected = [self numberOfStarAtPoint:point];
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






#pragma mark -
#pragma mark Draw

// algorythm http://processing.org/tutorials/anatomy/
void drawStar(CGContextRef context, CGRect rect, NSUInteger corners, UIColor * color, UIColor * emptyColor,
			  CGFloat proportion, CGFloat startAngle, BOOL full)
{
	if (corners > 2)
	{
		CGFloat 	lineWidth = MIN(rect.size.height, rect.size.width) / 13;

		CGContextSetLineWidth(context, lineWidth);

		CGColorRef drawColor;
		CGPathDrawingMode drawMode;

		if ( emptyColor && ! full )
		{
			drawColor = emptyColor.CGColor;
			drawMode = kCGPathFillStroke;
		}
		else
		{
			drawColor = color.CGColor;
			drawMode = full ? kCGPathFillStroke : kCGPathStroke;
		}

		CGContextSetStrokeColorWithColor(context, drawColor);
		CGContextSetFillColorWithColor(context, drawColor);


		float angle = (M_PI * 2) / (2 * corners);  // twice as many sides
		float dw; // draw width
		float dh; // draw height


		CGFloat width = rect.size.width - 2.5 * lineWidth;
		CGFloat height = rect.size.height - 2.3 * lineWidth;
		CGFloat w = width / 2.0;
		CGFloat h = height / 2.0;

		CGFloat cx = CGRectGetMidX(rect);
		CGFloat cy = CGRectGetMidY(rect) + lineWidth / 2;


		CGContextMoveToPoint(context, cx + w * cos(startAngle), cy + h * sin(startAngle));

		for (int i = 1; i < 2 * corners; i++)
		{
			if (i % 2 == 1)
			{
				dw = w * proportion;
				dh = h * proportion;
			}
			else
			{
				dw = w;
				dh = h;
			}

			CGContextAddLineToPoint(context, cx + dw * cos(startAngle + angle * i),
									cy + dh * sin(startAngle + angle * i));
		}

		CGContextClosePath(context);
		CGContextDrawPath(context, drawMode);
	}
}

CGRect starRect(CGRect rect, BOOL square)
{
	CGFloat width = rect.size.width;
	CGFloat height = rect.size.height;
	CGFloat x = rect.origin.x;
	CGFloat y = rect.origin.y;

	if ( square )
	{
		if ( height < width )
		{
			x += width / 2 - height / 2;
		}
		else
		{
			y += width / 2 - height / 2;
		}

		CGFloat min = MIN(height, width);

		width = min;
		height = min;
	}

	return CGRectMake(x, y, width, height);
}

- (void) drawRect:(CGRect)rect
{
	for (NSUInteger i = 0; i < _count; i++ )
	{
		CGFloat width = self.bounds.size.width / _count;
		CGFloat x = i * width;
		CGRect starRect_ = CGRectMake(x, 0, width, self.bounds.size.height);


		BOOL full = !(i+1 > _countOfSelected);

		// draw star
		drawStar(UIGraphicsGetCurrentContext(), starRect(starRect_, _square), 5, _strokeColor, _emptyColor, _proportion, (-M_PI / 2.0), full);
	}
}


@end
