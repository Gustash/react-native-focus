#import <Intents/Intents.h>

NS_ASSUME_NONNULL_BEGIN

@interface FocusStatusIntentHandler : NSObject

+ (void)handleShareFocusStatus:(INShareFocusStatusIntent *)intent
                    completion:(void (^)(INShareFocusStatusIntentResponse *))completion API_AVAILABLE(ios(15.0));

@end

NS_ASSUME_NONNULL_END
