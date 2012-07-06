#import <UIKit/UIKit.h>

@interface QuadrantView : UIView
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) BOOL rotation;
@property (nonatomic, retain) NSString* quadrantName;

- (id)initWithFrame:(CGRect)frame WithCenter:(CGPoint)point AndRotation:(BOOL)rotation AndName:(NSString*)quadName;
@end
