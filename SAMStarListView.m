//
//  SAMStarListView.m
//
//  Created by Roman Kříž on 02.06.13.
//  Copyright (c) 2013 samnung. All rights reserved.
//

#import "SAMStarListView.h"
#import "SAMStarView.h"


@implementation SAMStarListView
{
	
}

@synthesize count = _count, countOfFull = _countOfFull;


- (id) initWithFrame:(CGRect)frame count:(NSUInteger)count countOfFull:(NSUInteger)countOfFull
{
	self = [super initWithFrame:frame];
	
	if ( self )
	{
		_count = count;
		_countOfFull = countOfFull;
		
		for (NSUInteger i = 0; i < _count; i ++)
		{
			CGFloat width = self.frame.size.width / _count;
			CGFloat x = i * width;
			CGRect rect = CGRectMake(x, 0, width, self.frame.size.height);
			SAMStarView *star = [[SAMStarView alloc] initWithFrame:rect color:COLOR_BROWN_LIGHT andInnerColor:COLOR_BACKGROUND];
			star.full = !(i+1 > _countOfFull);
			[self addSubview:star];
		}
	}
	
	return self;
}

- (void) layoutSubviews
{
	NSUInteger i = 0;
	for ( UIView * view in self.subviews )
	{
		if ( [view isMemberOfClass:[SAMStarView class]] )
		{
			CGFloat width = self.frame.size.width / _count;
			CGFloat x = i * width;
			CGRect rect = CGRectMake(x, 0, width, self.frame.size.height);
			
			view.frame = rect;
			
			i++;
		}
	}
}

@end
