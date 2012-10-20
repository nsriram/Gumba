#import "DashboardViewController.h"
#import "ViewController.h"
#import "AboutRadarController.h"
#import "AppConstants.h"
#import <QuartzCore/QuartzCore.h>

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

-(IBAction) userGuide:(UIButton *)current {
    [self navigateTo:@"UserGuideViewController"];
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
    
    UIButton *currentRadarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    currentRadarButton.frame = CGRectMake(312, 413, 164, 127);
    [currentRadarButton addTarget:self action:@selector(currentRadar:) forControlEvents:UIControlEventTouchUpInside];
    [currentRadarButton setImage:[UIImage imageNamed:@"current_radar_button.png"] forState:UIControlStateNormal];
    [currentRadarButton setImage:[UIImage imageNamed:@"current_radar_button_highlighted.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:currentRadarButton];
    
    UIButton *aboutRadarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutRadarButton.frame = CGRectMake(343, 177, 100, 100);
    [aboutRadarButton addTarget:self action:@selector(aboutRadar:) forControlEvents:UIControlEventTouchUpInside];
    [aboutRadarButton setImage:[UIImage imageNamed:@"about_radar_button.png"] forState:UIControlStateNormal];
    [aboutRadarButton setImage:[UIImage imageNamed:@"about_radar_button_highlighted.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:aboutRadarButton];
    
    UIButton *userGuideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userGuideButton.frame = CGRectMake(95, 426, 100, 100);
    [userGuideButton addTarget:self action:@selector(userGuide:) forControlEvents:UIControlEventTouchUpInside];
    [userGuideButton setImage:[UIImage imageNamed:@"user_guide_button.png"] forState:UIControlStateNormal];
    [userGuideButton setImage:[UIImage imageNamed:@"user_guide_button_highlighted.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:userGuideButton];
    
    UIButton *aboutUsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutUsButton.frame = CGRectMake(580, 413, 125, 125);
    [aboutUsButton addTarget:self action:@selector(aboutTW:) forControlEvents:UIControlEventTouchUpInside];
    [aboutUsButton setImage:[UIImage imageNamed:@"about_us_button.png"] forState:UIControlStateNormal];
    [aboutUsButton setImage:[UIImage imageNamed:@"about_us_button_highlighted.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:aboutUsButton];
    
    UIButton *referencesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    referencesButton.frame = CGRectMake(309, 690, 175, 65);
    [referencesButton addTarget:self action:@selector(reference:) forControlEvents:UIControlEventTouchUpInside];
    [referencesButton setImage:[UIImage imageNamed:@"references_button.png"] forState:UIControlStateNormal];
    [referencesButton setImage:[UIImage imageNamed:@"references_button_highlighted.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:referencesButton];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}
@end
