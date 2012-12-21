#import "MessageStripe.h"

#import "MessageStripeAnimator.h"
#import "MessageStripeView.h"

@implementation MessageStripe

+ (void) showMessage:(NSString *)message
    inViewController:(UIViewController *)viewController
             inFrame: (CGRect)frame
{
    MessageStripeView *view = [[MessageStripeView alloc] init];
    
    view.text = message;
    view.frame = frame;
    
    [MessageStripeAnimator animateView:view inViewController:viewController];
}

@end