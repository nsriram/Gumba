#import "UserGuideViewController.h"
#import "AppConstants.h"

@interface UserGuideViewController ()

@end

@implementation UserGuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
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
    [self.view setBackgroundColor:[AppConstants detailBackgroundColor]];
    [self bindSwipeRight];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end