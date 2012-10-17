#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "QuadrantView.h"
#import "CircleView.h"
#import "Radar.h"
#import "AppConstants.h"
#import "ItemDetailViewController.h"

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
@synthesize selectedButton;
@synthesize barButtonColor;

-(void) showAllItems {
    for(QuadrantView *quadrantView in self.quadrantViews){
        NSArray *subViews = quadrantView.subviews;
        for(ItemView *subView in subViews){
            NSInteger ratioRadius = RADAR_RATIO*subView.radius;
            if(subView.alpha == 0.0 && ratioRadius > innerRadius && ratioRadius < outerRadius){
                [UIView animateWithDuration:0.3 animations:^() {
                    subView.alpha = 1.0;
                }];
            }
        }
    }    
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
                NSInteger ratioRadius = RADAR_RATIO*subView.radius;
                if(ratioRadius > innerRadius && ratioRadius < outerRadius){
                    if ([blipName rangeOfString:searchkey].location == NSNotFound) {
                        [UIView animateWithDuration:0.3 animations:^() {
                            subView.alpha = 0.0;
                        }];
                    }else{
                        [UIView animateWithDuration:0.3 animations:^() {
                            subView.alpha = 1.0;
                        }];
                    }}
            }
        }
    } else {
        [self showAllItems];
    }
}

-(void) hideCircle:(NSInteger) inRadius AndOuter:(NSInteger) outRadius{
    self.innerRadius = inRadius;
    self.outerRadius= outRadius;
        
    for(QuadrantView *quadrantView in self.quadrantViews){
        NSArray *subViews = quadrantView.subviews;
        for(ItemView *subView in subViews){
            NSInteger ratioRadius = RADAR_RATIO*subView.radius;
            if(ratioRadius > inRadius && ratioRadius < outRadius) {
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

-(void) highlightSelectedBarButton :(UIBarButtonItem *) barButton {
    if(selectedButton != NULL){
        [selectedButton setTintColor:barButtonColor];
    }else {
        barButtonColor = selectedButton.tintColor;
    }
    selectedButton = barButton;
    [selectedButton setTintColor:[UIColor darkGrayColor]];
}

-(IBAction) back:(UIBarButtonItem *)backButtobarButtonItem{
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(IBAction) adopt:(UIBarButtonItem *)adoptButtobarButtonItem{
    [self highlightSelectedBarButton:adoptButtobarButtonItem];
    [self hideCircle:0.0 AndOuter:150.0*RADAR_RATIO];
}

-(IBAction) trial:(UIBarButtonItem *)barButtonItem{
    [self highlightSelectedBarButton:barButtonItem];
    [self hideCircle:150.0*RADAR_RATIO AndOuter:275.0*RADAR_RATIO];
}
-(IBAction) assess:(UIBarButtonItem *)barButtonItem{
    [self highlightSelectedBarButton:barButtonItem];
    [self hideCircle:275.0*RADAR_RATIO AndOuter:350.0*RADAR_RATIO];
}

-(IBAction) hold:(UIBarButtonItem *)barButtonItem{
    [self highlightSelectedBarButton:barButtonItem];
    [self hideCircle:350.0*RADAR_RATIO AndOuter:400.0*RADAR_RATIO];
}

-(IBAction) all:(UIBarButtonItem *)barButtonItem{
    [self highlightSelectedBarButton:barButtonItem];
    self.innerRadius = 0.0;
    self.outerRadius = 400.0;
    [self hideCircle:0.0 AndOuter:400.0*RADAR_RATIO];
    [selectedButton setTintColor:barButtonColor];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if([_searchTerm length] > 0) {
        [self searchRadar:_searchTerm];
    }
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
    if([searchBar.text length] == 0) {
        [searchBar performSelector: @selector(resignFirstResponder)
                        withObject: nil
                        afterDelay: 0.1];
    }
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
    ItemDetailViewController *itemDetailViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemDetailViewController"];    
    ItemView *itemView = (ItemView *)sender.view;
    itemDetailViewController.detailText = [NSString stringWithFormat:@"%@",itemView.blipName];
    itemDetailViewController.descriptionText = itemView.description;
    itemDetailViewController.imageText = itemView.type;    
    [self.navigationController pushViewController:itemDetailViewController animated:YES];    
}

-(void) bindQuadrantTwoFingerPinch :(QuadrantView*)quadrantView {
    UIPinchGestureRecognizer *twoFingerPinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerPinch:)] ;
    [quadrantView addGestureRecognizer:twoFingerPinch];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerPinch:)];
    singleTap.numberOfTapsRequired = 1;
    [quadrantView addGestureRecognizer:singleTap];
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

- (void)swipeRight:(UIPinchGestureRecognizer *)recognizer  {
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void) bindSwipeRight {
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindSwipeRight];
    self.innerRadius=0.0;
    self.outerRadius=400.0;
    [[self view] setClipsToBounds:YES];
    _quadrantViews = [[NSMutableArray alloc] init];
    [self addQuadrants];
//    [self.view setBackgroundColor:[AppConstants backgroundColor]];
//    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg.png"]];
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