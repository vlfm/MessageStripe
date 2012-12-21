#import "MessageStripeAnimator.h"

static NSTimeInterval kAnimationDuration = 0.3;
static NSTimeInterval kDisplayTime       = 3.0;

@interface MessageStripeAnimator ()

+ (void) animateViewAppear: (UIView *)view inViewController: (UIViewController *)viewController onComplete: (void (^)())onComplete;
+ (void) animateViewDisappear: (UIView *)view inViewController: (UIViewController *)viewController;

@end

@implementation MessageStripeAnimator

+ (void) animateView: (UIView *)view inViewController: (UIViewController *)viewController
{
    [MessageStripeAnimator animateViewAppear:view
                            inViewController:viewController
     
                                  onComplete:^{
                                      [MessageStripeAnimator animateViewDisappear:view
                                                                 inViewController:viewController];
                          }];
}

+ (void) animateViewAppear: (UIView *)view inViewController: (UIViewController *)viewController onComplete: (void (^)())onComplete
{
    view.alpha = 0.0;
    [viewController.view addSubview:view];
    
    [UIView animateWithDuration:kAnimationDuration
     
                     animations:^ {
                         view.alpha = 1.0;
                     }
     
                     completion:^(BOOL finished) {
                         if (finished) {
                             onComplete();
                         }
                     }];
}

+ (void) animateViewDisappear: (UIView *)view inViewController: (UIViewController *)viewController
{
    [UIView animateWithDuration:kAnimationDuration
                          delay:kDisplayTime
                        options:UIViewAnimationOptionCurveEaseIn
     
                     animations:^ {
                         view.alpha = 0.0;
                     }
     
                     completion:^(BOOL finished) {
                         [view removeFromSuperview];
                     }];
}

@end
