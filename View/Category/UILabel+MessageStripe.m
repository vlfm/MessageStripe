#import "UILabel+MessageStripe.h"

static NSInteger kMaxHeight   = 9999;

static NSInteger kMinFontSize = 5;
static NSInteger kMaxFontSize = 24;

static NSInteger kTextPadding = 16;

@implementation UILabel (MessageStripe)

- (void) adjustFontSize
{
    float fontSize = kMaxFontSize;
    self.font = [self.font fontWithSize:fontSize];
    
    CGFloat textHeight = [self textHeight];
    while (textHeight >= self.frame.size.height)
    {
        if (fontSize <= kMinFontSize)
            return;
        
        fontSize -= 1.0;
        self.font = [self.font fontWithSize:fontSize];
        textHeight = [self textHeight];
    }
}

- (CGSize) tallerSize
{
    return CGSizeMake(self.frame.size.width - kTextPadding, kMaxHeight);
}

- (CGFloat) textHeight
{
    CGSize textSize = [self.text sizeWithFont:self.font constrainedToSize:[self tallerSize] lineBreakMode:UILineBreakModeWordWrap];
    return textSize.height + kTextPadding;
}

@end
