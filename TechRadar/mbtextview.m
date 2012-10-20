#import "mbtextview.h"

@interface UITextView ()
- (id)styleString; // make compiler happy
@end

@interface MBTextView : UITextView
@end
@implementation MBTextView
- (id)styleString {
    return [[super styleString] stringByAppendingString:@"; line-height: 1.25em"];
}
@end