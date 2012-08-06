#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "QuadrantView.h"
#import "CircleView.h"
#import "Radar.h"
#import "AppConstants.h"
#import "RadarItemDetailViewController.h"

@interface ViewController()
@property (nonatomic, assign) CGFloat lastScale;
@property (nonatomic, assign) CGFloat newScale;
@property (nonatomic, assign) NSInteger innerRadius;
@property (nonatomic, assign) NSInteger outerRadius;
@end

@implementation ViewController
@synthesize quadrantViews = _quadrantViews;
@synthesize lastScale = _lastScale;
@synthesize newScale = _newScale;
@synthesize searchTerm = _searchTerm;
@synthesize innerRadius,outerRadius;

-(void) hideCircle:(NSInteger) innerRadius AndOuter:(NSInteger) outerRadius{
    self.innerRadius = innerRadius;
    self.outerRadius= outerRadius;

    for(QuadrantView *quadrantView in self.quadrantViews){
        NSArray *subViews = quadrantView.subviews;
        for(ItemView *subView in subViews){
            NSInteger ratioRadius = RADAR_RATIO*subView.radius;
            if(ratioRadius > innerRadius && ratioRadius < outerRadius) {
                [UIView animateWithDuration:0.3 animations:^() {
                    subView.alpha = 1.0;
                }];
            }else {
                [UIView animateWithDuration:0.3 animations:^() {
                    subView.alpha = 0.0;
                }];
            }
        }
    }
}

-(void) showAllItems {
    for(QuadrantView *quadrantView in self.quadrantViews){
        NSArray *subViews = quadrantView.subviews;
        for(ItemView *subView in subViews){
            if(subView.alpha == 0.0){
                [UIView animateWithDuration:0.3 animations:^() {
                    subView.alpha = 1.0;
                }];
            }
        }
    }    
}

-(IBAction) adopt:(UIBarButtonItem *)adoptButtobarButtonItem{
    [self hideCircle:0.0 AndOuter:150.0*RADAR_RATIO];
}

-(IBAction) trial:(UIBarButtonItem *)barButtonItem{
    [self hideCircle:150.0*RADAR_RATIO AndOuter:275.0*RADAR_RATIO];
}
-(IBAction) assess:(UIBarButtonItem *)barButtonItem{
    [self hideCircle:275.0*RADAR_RATIO AndOuter:350.0*RADAR_RATIO];
}

-(IBAction) hold:(UIBarButtonItem *)barButtonItem{
    [self hideCircle:350.0*RADAR_RATIO AndOuter:400.0*RADAR_RATIO];
}
-(IBAction) all:(UIBarButtonItem *)barButtonItem{
    self.innerRadius = 0.0;
    self.outerRadius = 400.0;
    [self hideCircle:0.0 AndOuter:400.0*RADAR_RATIO];
}

-(void) searchRadar:(NSString*) searchkey {
    searchkey = [searchkey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ];
    searchkey = [searchkey lowercaseString];
    _searchTerm = searchkey;
    if([searchkey length] != 0) {
        for(QuadrantView *quadrantView in self.quadrantViews){
            NSArray *subViews = quadrantView.subviews;
            for(ItemView *subView in subViews){
                NSString *blipName = [subView blipName];
                blipName = [blipName lowercaseString];
                if ([blipName rangeOfString:searchkey].location == NSNotFound) {
                    [UIView animateWithDuration:0.3 animations:^() {
                        subView.alpha = 0.0;
                    }];
                }else{
                    [UIView animateWithDuration:0.3 animations:^() {
                        subView.alpha = 1.0;
                    }];
                }
            }
        }
    } else {
        [self showAllItems];
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self searchRadar:_searchTerm];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    _searchTerm=@"";
    [self searchRadar:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchRadar:searchBar.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self searchRadar:searchBar.text];
}

- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer  {
    const CGFloat kMaxScale = 2.0;
    const CGFloat kMinScale = 1.0;
    
    if([recognizer state] == UIGestureRecognizerStateBegan) {
        self.lastScale = [recognizer scale];
    }
    
    if ([recognizer state] == UIGestureRecognizerStateBegan ||
        [recognizer state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[[recognizer view].layer valueForKeyPath:@"transform.scale"] floatValue];
        
        self.newScale = 1 -  (self.lastScale - [recognizer scale]);
        self.newScale = MIN(self.newScale, kMaxScale / currentScale);
        self.newScale = MAX(self.newScale, kMinScale / currentScale);        
        self.lastScale = [recognizer scale];
    }
    
    if([recognizer state] == UIGestureRecognizerStateEnded) {
        QuadrantView *quadrantView = (QuadrantView *)recognizer.view;
        [quadrantView resize:self.navigationItem];
    }
}

-(IBAction) displayItemDetails:(UIGestureRecognizer*)sender {
    ItemView *itemView = (ItemView *)sender.view;
    RadarItemDetailViewController *controller = [[RadarItemDetailViewController alloc]init];
    controller.delegate=self;
    controller.detailText = [NSString stringWithFormat:@"%@",itemView.blipName];
    controller.imageText = itemView.type;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle= UIModalPresentationFormSheet;
    [self presentModalViewController:controller animated:YES];
    controller.view.superview.frame = CGRectMake(0, 0, 320, 200);
    controller.view.superview.center = self.view.center;
}

-(void) bindQuadrantTwoFingerPinch :(QuadrantView*)quadrantView {
    UIPinchGestureRecognizer *twoFingerPinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerPinch:)] ;
    [quadrantView addGestureRecognizer:twoFingerPinch];
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
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    CGPoint origin = CGPointMake(x, y);
    CGRect frame = CGRectMake(origin.x, origin.y, screenWidth/2, ((screenHeight-Y_OFFSET-self.navigationController.navigationBar.frame.size.height)/2));
    
    CGFloat centerX = (x > 0.0 ? 0.0 : screenWidth/2);
    CGFloat centerY = (y > Y_OFFSET ? 0.0 : ((screenHeight-Y_OFFSET-self.navigationController.navigationBar.frame.size.height)/2));
    
    QuadrantView *quadrantView = [[QuadrantView alloc]initWithFrame:frame
                                                         WithCenter:CGPointMake(centerX,centerY)
                                                        AndQuadrant:quadrant];
    [quadrantView addCircleViews];
    [quadrantView addTriangleViews];
    [self bindQuadrantTwoFingerPinch:quadrantView];
    [self bindItemTap:quadrantView];
    
    [_quadrantViews addObject:quadrantView];
    return quadrantView;
}

-(void) addQuadrants {
    Radar *radar = [Radar radarFromFile:@"radar"];
    NSMutableArray *allQuadrants = [radar quadrants];
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGFloat midPointX = screenWidth/2;
    CGFloat midPointY = ((screenHeight-Y_OFFSET-self.navigationController.navigationBar.frame.size.height)/2)+Y_OFFSET;
    
    [self.view insertSubview:[self quadrantOriginX:0.0 Y:Y_OFFSET Quadrant:[allQuadrants objectAtIndex:0]] atIndex:1];
    [self.view insertSubview:[self quadrantOriginX:midPointX Y:Y_OFFSET Quadrant:[allQuadrants objectAtIndex:1]] atIndex:1];
    [self.view insertSubview:[self quadrantOriginX:0.0 Y:midPointY Quadrant:[allQuadrants objectAtIndex:2]] atIndex:1];
    [self.view insertSubview:[self quadrantOriginX:midPointX Y:midPointY Quadrant:[allQuadrants objectAtIndex:3]] atIndex:1];
} 

-(void) radarItemViewController:(RadarItemDetailViewController*)sender{
    [self dismissModalViewControllerAnimated:YES];
    if([_searchTerm length] > 0)
        [self searchRadar:_searchTerm];
    if(self.outerRadius > 0.0)
        [self hideCircle:self.innerRadius AndOuter:self.outerRadius];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view] setClipsToBounds:YES];
    _quadrantViews = [[NSMutableArray alloc] init];
    [self addQuadrants];
    [self.view setBackgroundColor:[AppConstants backgroundColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}
@end