#import "MessageStripeView.h"

#import "UILabel+MessageStripe.h"

@interface MessageStripeView ()

@property (nonatomic, weak) UILabel *label;

- (CGPathRef) pathToDraw;
- (void) clipContextToDrawPath: (CGContextRef)context;
- (void) drawGradientInContext: (CGContextRef)context;
- (void) drawBorderLineWithInnerShadowInContext: (CGContextRef)context;
- (void) drawBorderLineWithInnerShadowInContext: (CGContextRef)context
                                    shadowWidth: (CGFloat)shadowWidth;
- (void) reDrawBorderLineWithInnerShadowInContext: (CGContextRef)context;

@end

@implementation MessageStripeView

- (id) init
{
    self = [super init];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"Trebuchet MS" size:18];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.numberOfLines = 0;
    
    self.backgroundColor = [UIColor clearColor];
    label.backgroundColor = [UIColor clearColor];
    
    [self addSubview:label];
    self.label = label;
    
    return self;
}

- (void) setFrame: (CGRect)frame
{
    [super setFrame:frame];
    
    CGRect labelFrame = frame;
    labelFrame.origin.x = 0;
    labelFrame.origin.y = 0;
    
    [self.label setFrame:labelFrame];
    [self.label adjustFontSize];
}

- (NSString *) text
{
    return self.label.text;
}

- (void) setText: (NSString *)text
{
    self.label.text = text;
    [self.label adjustFontSize];
}

- (void) drawRect: (CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
    [self clipContextToDrawPath:context];
    [self drawGradientInContext:context];
    [self drawBorderLineWithInnerShadowInContext:context];
    [self reDrawBorderLineWithInnerShadowInContext:context];
}

- (void) clipContextToDrawPath: (CGContextRef)context
{
    CGContextSaveGState(context);
	CGContextAddPath(context, [self pathToDraw]);
	CGContextClip(context);
}

- (CGPathRef) pathToDraw
{
    CGFloat cornerRadius = 10.0;
	CGFloat inset = 1.5;
	CGFloat x = self.bounds.origin.x + inset;
	CGFloat y = self.bounds.origin.y + inset;
	CGFloat w = self.bounds.size.width  - (inset * 2.0);
	CGFloat h = self.bounds.size.height - (inset * 2.0);
    
	CGRect bPathFrame = CGRectMake(x, y, w, h);
    return [UIBezierPath bezierPathWithRoundedRect:bPathFrame cornerRadius:cornerRadius].CGPath;
}

- (void) drawGradientInContext: (CGContextRef)context
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	size_t count = 3;
	CGFloat locations[3] = {0.0, 0.57, 1.0};
	CGFloat components[12] =
	{
        70.0/255.0, 70.0/255.0, 70.0/255.0, 1.0,
		55.0/255.0, 55.0/255.0, 55.0/255.0, 1.0,
		40.0/255.0, 40.0/255.0, 40.0/255.0, 1.0
    };
    
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, count);
    
	CGPoint startPoint = CGPointMake(self.bounds.size.width * 0.5, 0.0);
	CGPoint endPoint   = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height);
    
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	CGColorSpaceRelease(colorSpace);
	CGGradientRelease(gradient);
}

- (void) drawBorderLineWithInnerShadowInContext: (CGContextRef)context
{
    [self drawBorderLineWithInnerShadowInContext:context shadowWidth:3.0];
}

- (void) drawBorderLineWithInnerShadowInContext: (CGContextRef)context
                                    shadowWidth: (CGFloat)shadowWidth
{
    CGContextAddPath(context, [self pathToDraw]);
	CGContextSetLineWidth(context, 3.0);
	CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:210.0/255.0
                                                              green:210.0/255.0
                                                               blue:210.0/255.0
                                                              alpha:1.0].CGColor);
    
	CGContextSetShadowWithColor(context, CGSizeMake(0.0, 0.0), shadowWidth,
                                [UIColor colorWithRed:0.0/255.0
                                                green:0.0/255.0
                                                 blue:0.0/255.0
                                                alpha:1.0].CGColor);
    
	CGContextDrawPath(context, kCGPathStroke);
}

- (void) reDrawBorderLineWithInnerShadowInContext: (CGContextRef)context
{
    CGContextRestoreGState(context);
    [self drawBorderLineWithInnerShadowInContext:context shadowWidth:0.0];
}

@end
