#import <UIKit/UIKit.h>

@interface TriangleView : UIView
@property (nonatomic, assign) NSInteger entry;
@property (nonatomic, retain) NSString* blipName;
- (id)initWithFrame:(CGRect)frame AndEntry:(NSInteger)entry AndBlip:(NSString*)blipName;
-(void) minimize;
-(void) maximize;
@end
