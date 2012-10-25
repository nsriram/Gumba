#import "AboutRadarController.h"
#import "AppConstants.h"
#import <QuartzCore/QuartzCore.h>

@implementation AboutRadarController
@synthesize detail;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)swipeRight:(UIPinchGestureRecognizer *)recognizer  {
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void) bindSwipeRight {
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)] ;
    singleTap.numberOfTapsRequired = 1;
    [[self view] addGestureRecognizer:singleTap];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"about_radar.png"]];
    [self bindSwipeRight];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


@end
