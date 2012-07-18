#import "QuadrantView.h"
#import "CircleView.h"
#import "TriangleView.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SBJson.h"
#import "AppConstants.h"

@interface QuadrantView()
@property (nonatomic, assign) CGPoint frameOrigin;
@end

@implementation QuadrantView

@synthesize center;
@synthesize frameOrigin;
@synthesize quadrantName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

-(CGPoint) rasterFromAngle:(int) angle AndRadius:(int)radius {
    CGFloat x = radius * cos((angle * M_PI/180));
    CGFloat y = radius * sin((angle * M_PI/180));  
    return CGPointMake(x,y);
}

- (void)resizeQuadrant
{
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:animationIDfinished:finished:context:)];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.50];
	[UIView setAnimationTransition:([self superview] ? UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromLeft)
                           forView:self
                             cache:NO];
    CGRect resized;
    if(self.frame.size.height == 1004){
        for(CircleView *subView in self.subviews){
            CGRect currentFrame = subView.frame;
            [subView setFrame:CGRectMake(currentFrame.origin.x/2.0, currentFrame.origin.y/2.0, currentFrame.size.width/2.0, currentFrame.size.height/2.0)];
        }
        resized = CGRectMake(self.frameOrigin.x, self.frameOrigin.y, 384, 502);
    } else {
        for(CircleView *subView in self.subviews){
            CGRect currentFrame = subView.frame;
            [subView setFrame:CGRectMake(currentFrame.origin.x*2.0, currentFrame.origin.y*2.0, currentFrame.size.width*2.0, currentFrame.size.height*2.0)];
        }
        resized = CGRectMake(0, 0, 768, 1004);
        [self.superview bringSubviewToFront:self];
    }
    self.frame = resized;	
	[UIView commitAnimations];	
}

- (id)initWithFrame:(CGRect)frame WithCenter:(CGPoint)point AndName:(NSString*) quadName {
    self = [super initWithFrame:frame];
    if (self) {
        self.frameOrigin=self.frame.origin;
        self.center = point;
        self.quadrantName = quadName;
        UITapGestureRecognizer *doubleTap = 
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resizeQuadrant)];        
        [doubleTap setNumberOfTapsRequired:2];
        [self addGestureRecognizer:doubleTap];        

    }
    return self;
}

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, M_PI*2.0, true);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}   

+(NSMutableDictionary *)readJSON {
    NSString *gumbaJSON = @"";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:GUMBA ofType:JSON];  
    if (filePath) {
        gumbaJSON = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];  
    }
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    return [parser objectWithString:gumbaJSON error:nil];    
}

-(void) drawBackgroundGradient : (CGContextRef) context{
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0};
    CGFloat components[12] = {  70.0/255.0, 130.0/255.0, 170.0/255.0, 0.8, 
        70.0/255.0, 130.0/255.0, 170.0/255.0, 0.8 };
    CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef myGradient = CGGradientCreateWithColorComponents (myColorspace, 
                                                                    components,locations, 
                                                                    num_locations);
    CGPoint myStartPoint, myEndPoint;    
    myStartPoint.x = 0.0;    
    myStartPoint.y = 0.0;
    myEndPoint.x = self.frame.size.width;
    myEndPoint.y = self.frame.size.height;    
    CGContextDrawLinearGradient (context, myGradient, myStartPoint, myEndPoint, 0);
}

- (void) drawArcTitles :(CGContextRef) context withTitle:(NSString*)label Width:(CGFloat)width Height:(CGFloat)distance{
    [[UIColor whiteColor] set];
    UIFont *font = [UIFont systemFontOfSize:18];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.center.x +width, self.center.y+distance);
    CGAffineTransform textTransform = CGAffineTransformMakeRotation(-1.57/2.0);
    CGContextConcatCTM(context, textTransform);
    CGContextTranslateCTM(context, -(self.center.x +width), -(self.center.y+distance));
    [label drawAtPoint:CGPointMake(self.center.x +width, self.center.y+distance) withFont:font];
    CGContextRestoreGState(context);
}

-(NSInteger) rangeBegin :(NSMutableDictionary*) allQuadrants {
    NSMutableArray *allRanges = [allQuadrants objectForKey:@"radar_quadrants"];
    NSInteger rangeBegin;
    for(NSMutableDictionary *range in allRanges){
        NSString *name =  [range objectForKey:@"name"];
        if([name isEqualToString:quadrantName]){
            rangeBegin = [[range objectForKey:@"start"] integerValue];
        }
    }
    return rangeBegin + 1;
}

-(void) drawQuadrantLabelInContext:(CGContextRef)context{
    float labelX = self.frame.size.width/3.0;
    float labelYDelta = 60.0;
    float labelY=0;
    
    if(self.frameOrigin.y == 0){
        labelY = labelYDelta;
    } else {
        labelY = self.frame.size.height - labelYDelta;
    }
    
    UIGraphicsPushContext(context);
    [[UIColor whiteColor] set]; 
    UIFont *font = [UIFont systemFontOfSize:20];
    CGPoint textPoint = CGPointMake(labelX,labelY);
    [self.quadrantName drawAtPoint:textPoint withFont:font];
    UIGraphicsPopContext();
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();     

    [self drawBackgroundGradient:context];

    NSMutableDictionary *allQuadrants = [QuadrantView readJSON];
    NSMutableArray *names = [allQuadrants objectForKey:quadrantName];
    NSInteger rangeBegin = [self rangeBegin:allQuadrants];
    
    for(NSMutableDictionary *blip in names){
        NSString *blipName = [blip objectForKey:@"name"];
        NSString *movement = [blip objectForKey:@"movement"];
        
        NSMutableDictionary *pcMap = [blip objectForKey:@"pc"];
        NSString *r = [pcMap objectForKey:@"r"];
        NSString *t = [pcMap objectForKey:@"t"];
        CGPoint point = [self rasterFromAngle:[t intValue] AndRadius:[r intValue]];
        
        if(point.x < 0){
            point.x = 378.0 + point.x;
        } 
        if(point.y <0){
            point.y = (point.y * -1);
        } else {
            point.y = (494.0 - point.y);
        }
        if([movement isEqualToString:@"t"]){
            CGRect someRect = CGRectMake(point.x, point.y, 18.0, 18.0);
            TriangleView *triangleView = [[TriangleView alloc] initWithFrame:someRect AndEntry:rangeBegin AndBlip:blipName];
            [self insertSubview:triangleView atIndex:1];
        }else {
            CGRect someRect = CGRectMake(point.x, point.y, 18.0, 18.0);
            CircleView *circleView = [[CircleView alloc] initWithFrame:someRect AndEntry:rangeBegin AndBlip:blipName];
            [self insertSubview:circleView atIndex:1];
        }        
        rangeBegin = rangeBegin +1;
    }


    CGContextSetLineWidth(context, 2.0);
    [[UIColor whiteColor] setStroke];
    
    [self drawCircleAtPoint:self.center withRadius:150 inContext:context];
    [self drawCircleAtPoint:self.center withRadius:275 inContext:context];
    [self drawCircleAtPoint:self.center withRadius:350 inContext:context];    
    [self drawCircleAtPoint:self.center withRadius:400 inContext:context];    
    
    CGRect    myFrame = self.bounds;
    CGContextSetLineWidth(context, 1);
    CGRectInset(myFrame, 2, 2);
    [[UIColor whiteColor] set];
    UIRectFrame(myFrame);

    [self drawArcTitles:context withTitle:@"Adopt" Width:80.0 Height:130.0];
    [self drawArcTitles:context withTitle:@"Trial" Width:165.0 Height:225.0];
    [self drawArcTitles:context withTitle:@"Assess" Width:210.0 Height:280.0];
    [self drawArcTitles:context withTitle:@"Hold" Width:250.0 Height:315.0];    

    [self drawQuadrantLabelInContext:context];
}
@end