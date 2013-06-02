//
//  SAMStarView.m
//
//  Created by Roman Kříž on 02.06.13.
//  Copyright (c) 2013 samnung. All rights reserved.
//

#import "SAMStarView.h"

@implementation SAMStarView

@synthesize full = _full, color = _color, innerColor = _innerColor;


# pragma mark Init

- (id) initWithFrame:(CGRect)frame color:(UIColor *)color andInnerColor:(UIColor *)innerColor
{
    self = [super initWithFrame:frame];
	
    if (self)
	{
		_color = color;
		_innerColor = innerColor;
		_full = YES;
		
		[self setBackgroundColor:[UIColor clearColor]];
    }
	
    return self;
}



#pragma mark Setters

- (void) setFull:(BOOL)full
{
	_full = full;
	[self setNeedsDisplay];
}

- (void) setColor:(UIColor *)color
{
	_color = color;
	[self setNeedsDisplay];
}

- (void) setInnerColor:(UIColor *)innerColor
{
	_innerColor = innerColor;
	[self setNeedsDisplay];
}


#pragma mark Draw

- (void) drawStarInRect:(CGRect)rect withColor:(UIColor *)color
{
	int aSize = 0.0;
	
    CGColorRef aColor = color.CGColor;
	
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, aSize);

	
    CGFloat xCenter = rect.origin.x + rect.size.width / 2;
    CGFloat yCenter = rect.origin.y + rect.size.height / 2;
	
    float  w = MIN(rect.size.width, rect.size.height);
    double r = w / 2.0;
    float flip = -1.0;
	
	
	CGContextSetFillColorWithColor(context, aColor);
	CGContextSetStrokeColorWithColor(context, aColor);
	
	double theta = 2.0 * M_PI * (2.0 / 5.0); // 144 degrees
	
	CGContextMoveToPoint(context, xCenter, r*flip+yCenter);
	
	for ( NSUInteger k = 1; k < 5; k++ )
	{
		float x = r * sin(k * theta);
		float y = r * cos(k * theta);
		CGContextAddLineToPoint(context, x+xCenter, y*flip+yCenter);
	}
    
    CGContextClosePath(context);
	CGContextFillPath(context);
}

- (void) drawRect:(CGRect)rect
{
	[super drawRect:rect];

	// draw star
	[self drawStarInRect:rect withColor:_color];
	
	// draw inner star as empty star
	if ( ! _full )
	{
		CGFloat width = rect.size.width;
		CGFloat x = width / 4;
		width -= x * 2;
		
		CGFloat height = rect.size.height;
		CGFloat y = height / 4;
		
		height -= y * 2;
		
		CGRect rect_ = CGRectMake(x, y, width, height);
		[self drawStarInRect:rect_ withColor:_innerColor];
	}
}



@end
