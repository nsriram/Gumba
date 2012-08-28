#import "DashboardViewController.h"
#import "ViewController.h"
#import "AboutRadarController.h"
#import "AppConstants.h"

@implementation DashboardViewController

- (void)navigateTo:(NSString*)controllerName {
    ViewController *viewController = 
    [self.storyboard instantiateViewControllerWithIdentifier:controllerName];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction) currentRadar:(UIButton *)current {
    [self navigateTo:@"CurrentRadarController"];
}

-(IBAction) aboutRadar:(UIButton *)current {
    [self navigateTo:@"AboutRadarController"];
}

-(IBAction) aboutTW:(UIButton *)current {
    [self navigateTo:@"TWViewController"];
}

-(IBAction) reference:(UIButton *)current {
    [self navigateTo:@"ReferenceViewController"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}
@end
