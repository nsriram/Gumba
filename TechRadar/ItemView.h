#import <UIKit/UIKit.h>

@interface ItemView : UIView <UIActionSheetDelegate>
@property (nonatomic, assign) NSInteger entry;
@property (nonatomic, strong) NSString* blipName;
- (id)initWithFrame:(CGRect)frame AndEntry:(NSInteger)entry AndBlip:(NSString*)blipName;
-(void) drawTextWithContext:(CGContextRef)context Text:(NSString*)text Font:(UIFont*)font At:(CGPoint) point Angle:(CGFloat)angle;
-(void) minimize;
-(void) maximize;
@end
