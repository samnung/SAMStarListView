//
//  SAMStarView.m
//
//  Created by Roman Kříž on 02.06.13.
//  Copyright (c) 2013 samnung. All rights reserved.
//

#import "SAMStarView.h"

@implementation SAMStarView

@synthesize full = _full, color = _color, square = _square, emptyColor = _emptyColor, proportion = _proportion;


# pragma mark Init

- (id) initWithFrame:(CGRect)frame color:(UIColor *)color
{
    self = [super initWithFrame:frame];
	
    if (self)
	{
		_color = color;
		
		_full = YES;
		_square = NO;
		
		_proportion = 0.38;
		
		_emptyColor = nil;
		
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

- (void) setSquare:(BOOL)rectangle
{
	_square = rectangle;
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


#pragma mark Draw


void drawStar(CGContextRef context, CGRect rect, NSUInteger corners, UIColor * color, UIColor * emptyColor,
			  CGFloat proportion, CGFloat startAngle, BOOL full)
{
	if (corners > 2)
	{
		CGFloat 	lineWidth = MIN(rect.size.height, rect.size.width) / 13;
		
		CGContextSetLineWidth(context, lineWidth);
		
		CGColorRef drawColor;
		CGPathDrawingMode drawMode;
		
		if ( emptyColor )
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
	[super drawRect:rect];
	
	// draw star
	drawStar(UIGraphicsGetCurrentContext(), starRect(rect, _square), 5, _color, _emptyColor, _proportion, (-M_PI / 2.0), _full);

}



@end
