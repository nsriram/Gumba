#import <UIKit/UIKit.h>

@interface QuadrantView : UIView
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, retain) NSString* quadrantName;

- (id)initWithFrame:(CGRect)frame WithCenter:(CGPoint)point AndName:(NSString*)quadName;
@end