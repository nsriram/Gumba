#import "RadarItemDetailViewController.h"
#import "AppConstants.h"

@implementation RadarItemDetailViewController
@synthesize detail,detailText,delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[AppConstants backgroundColor]];
    [self.detail setText:detailText];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

-(IBAction) ok:(UIButton *)ok {
    [self.delegate radarItemViewController:self];
}
@end
