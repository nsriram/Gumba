#import "DashboardViewController.h"
#import "ViewController.h"
#import "AboutRadarController.h"
#import "AppConstants.h"

@implementation DashboardViewController

-(IBAction) currentRadar:(UIButton *)current {
    ViewController *viewController = 
    [self.storyboard instantiateViewControllerWithIdentifier:@"CurrentRadarController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction) aboutRadar:(UIButton *)current {
    ViewController *viewController = 
    [self.storyboard instantiateViewControllerWithIdentifier:@"AboutRadarController"];
    [self.navigationController pushViewController:viewController animated:YES];    
}

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
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}
@end
