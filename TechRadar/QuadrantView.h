#import <UIKit/UIKit.h>
#import "Quadrant.h"

@interface QuadrantView : UIView
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGPoint frameOrigin;
@property (nonatomic, strong) Quadrant* quadrant;

- (id)initWithFrame:(CGRect)frame WithCenter:(CGPoint)point AndQuadrant:(Quadrant*)quadrant;
- (void) resize;
- (void)addCircleViews;
- (void)addTriangleViews;
@end