#import <UIKit/UIKit.h>

@interface QuadrantView : UIView
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) BOOL rotation;

- (id)initWithFrame:(CGRect)frame WithCenter:(CGPoint)point AndRotation:(BOOL)rotation;
@end
