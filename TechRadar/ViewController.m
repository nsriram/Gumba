#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "QuadrantView.h"
#import "Radar.h"
#import "AppConstants.h"

@implementation ViewController

-(QuadrantView*) quadrantOriginX:(CGFloat)x Y:(CGFloat)y Quadrant:(Quadrant*)quadrant{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    CGPoint origin = CGPointMake(x, y);
    CGRect frame = CGRectMake(origin.x, origin.y, screenWidth/2, screenHeight/2);
    CGFloat centerX = (x > 0.0 ? 0.0 : screenWidth/2);
    CGFloat centerY = (y > 0.0 ? 0.0 : screenHeight/2);
    return [[QuadrantView alloc]initWithFrame:frame
                                   WithCenter:CGPointMake(centerX,centerY)
                                      AndQuadrant:quadrant];
}

-(void) addQuadrants {
    Radar *radar = [Radar radarFromFile:@"radar"];
    NSMutableArray *allQuadrants = [radar quadrants];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGFloat midPointX = screenWidth/2;
    CGFloat midPointY = screenHeight/2;

    [self.view insertSubview:[self quadrantOriginX:0.0 Y:0.0 Quadrant:[allQuadrants objectAtIndex:0]] atIndex:1];
    [self.view insertSubview:[self quadrantOriginX:midPointX Y:0.0 Quadrant:[allQuadrants objectAtIndex:1]] atIndex:1];
    [self.view insertSubview:[self quadrantOriginX:0.0 Y:midPointY Quadrant:[allQuadrants objectAtIndex:2]] atIndex:1];
    [self.view insertSubview:[self quadrantOriginX:midPointX Y:midPointY Quadrant:[allQuadrants objectAtIndex:3]] atIndex:1];
} 

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addQuadrants];
    [self.view setBackgroundColor:[AppConstants backgroundColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}
@end