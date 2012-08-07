#import <UIKit/UIKit.h>

@interface ItemView : UIView <UIActionSheetDelegate>
@property (nonatomic, assign) NSInteger entry;
@property (nonatomic, strong) NSString* blipName;
@property (nonatomic, strong) NSString* tip;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, assign) NSInteger radius;
@property (nonatomic, assign) BOOL isMinized;
- (id)initWithFrame:(CGRect)frame Entry:(NSInteger)entry Tip:(NSString*)tip Blip:(NSString*)blipName Type:(NSString*)type Radius:(NSInteger) radius;
-(void) drawTextWithContext:(CGContextRef)context Text:(NSString*)text Font:(UIFont*)font At:(CGPoint) point Angle:(CGFloat)angle;
-(void) minimize;
-(void) maximize;
@end
