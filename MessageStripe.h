#import <Foundation/Foundation.h>

@interface MessageStripe : NSObject

+ (void) showMessage:(NSString *)message
    inViewController:(UIViewController *)viewController
             inFrame: (CGRect)frame;

@end
