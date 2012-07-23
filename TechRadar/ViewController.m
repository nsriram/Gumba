#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "QuadrantView.h"
#import "CircleView.h"
#import "Radar.h"
#import "AppConstants.h"

@implementation ViewController
@synthesize quadrantViews = _quadrantViews;

- (void)resize:(UIGestureRecognizer*)sender {
    QuadrantView *quadrantView = (QuadrantView *)sender.view;
    [quadrantView resize];
}

-(IBAction) displayItemDetails:(UIGestureRecognizer*)sender {
    ItemView *itemView = (ItemView *)sender.view;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:itemView.blipName
                                                       delegate:itemView
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"ok" ,nil];
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    [sheet setBackgroundColor:[UIColor grayColor]];
    [sheet showInView:itemView];
}

-(void) bindDoubleTap :(QuadrantView*)quadrantView {
    UITapGestureRecognizer *doubleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resize:)];
    [doubleTap setNumberOfTapsRequired:2];
    [quadrantView addGestureRecognizer:doubleTap];        
}

-(void) bindItemTap: (QuadrantView*)quadrantView {
    NSArray *subViews = quadrantView.subviews;
    for(CircleView *subView in subViews){        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(displayItemDetails:)];
        [singleTap setNumberOfTapsRequired:1];
        [subView setUserInteractionEnabled:YES];
        [subView addGestureRecognizer:singleTap];        
    }
}

-(QuadrantView*) quadrantOriginX:(CGFloat)x Y:(CGFloat)y Quadrant:(Quadrant*)quadrant{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    CGPoint origin = CGPointMake(x, y);
    CGRect frame = CGRectMake(origin.x, origin.y, screenWidth/2, screenHeight/2);
    CGFloat centerX = (x > 0.0 ? 0.0 : screenWidth/2);
    CGFloat centerY = (y > 0.0 ? 0.0 : screenHeight/2);
    QuadrantView *quadrantView = [[QuadrantView alloc]initWithFrame:frame
                            WithCenter:CGPointMake(centerX,centerY)
                                                    AndQuadrant:quadrant];
    [quadrantView addCircleViews];
    [quadrantView addTriangleViews];
    [self bindDoubleTap:quadrantView];
    [self bindItemTap:quadrantView];

    [_quadrantViews addObject:quadrantView];
    return quadrantView;
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