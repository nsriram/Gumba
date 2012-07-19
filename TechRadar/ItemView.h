#import <UIKit/UIKit.h>

@interface ItemView : UIView <UIActionSheetDelegate>
@property (nonatomic, assign) NSInteger entry;
@property (nonatomic, retain) NSString* blipName;
- (id)initWithFrame:(CGRect)frame AndEntry:(NSInteger)entry AndBlip:(NSString*)blipName;
-(void) drawBackgroundGradient : (CGContextRef) context;
-(void) minimize;
-(void) maximize;
@end
