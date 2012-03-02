#import "QuadrantView.h"

@interface QuadrantView()
@property (nonatomic, assign) CGPoint frameOrigin;
@end

@implementation QuadrantView

@synthesize center,rotation;
@synthesize frameOrigin;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame WithCenter:(CGPoint)point AndRotation:(BOOL)arcRotation
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frameOrigin=self.frame.origin;
        self.center = point;
        self.rotation = arcRotation;

        UITapGestureRecognizer *doubleTap = 
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resizeQuadrant)];
        
        [doubleTap setNumberOfTapsRequired:2];
        [doubleTap setNumberOfTouchesRequired:1];
        
        [self addGestureRecognizer:doubleTap];

    }
    return self;
}

- (void)resizeQuadrant
{
    CGRect resized;
    if(self.frame.size.height == 1004){
        resized = CGRectMake(self.frameOrigin.x, self.frameOrigin.y, 384, 502);
    } else {
        resized = CGRectMake(0, 0, 768, 1004);
        [self.superview bringSubviewToFront:self];
    }
    self.frame = resized;
}

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, M_PI, self.rotation);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}   

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect    myFrame = self.bounds;
    CGContextSetLineWidth(context, 2);
    CGRectInset(myFrame, 2, 2);
    [[UIColor blackColor] set];
    UIRectFrame(myFrame);
    
    CGContextSetLineWidth(context, 5.0);
    [[UIColor whiteColor] setStroke];
    
    [self drawCircleAtPoint:self.center withRadius:125 inContext:context];
    [self drawCircleAtPoint:self.center withRadius:200 inContext:context];
    [self drawCircleAtPoint:self.center withRadius:275 inContext:context];    
    [self drawCircleAtPoint:self.center withRadius:350 inContext:context];    
}

@end
