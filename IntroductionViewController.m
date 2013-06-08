#import "IntroductionViewController.h"
#import "PreviewViewController.h"

@interface IntroductionViewController ()

@end

@implementation IntroductionViewController
@synthesize trendsWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *htmlBundle = [[NSBundle mainBundle] pathForResource:@"trends" ofType:@"html"];
    [trendsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlBundle isDirectory:NO]]];
}

- (IBAction)faq:(UIButton *)button {
    [self performSegueWithIdentifier:@"intro-to-preview" sender:@"http://martinfowler.com/articles/radar-faq.html"];
}

- (IBAction)radar:(UIButton *)button {
    [self performSegueWithIdentifier:@"intro-to-preview" sender:@"http://www.thoughtworks.com/radar"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSString *)url {
    if ([segue.identifier isEqualToString:@"intro-to-preview"]) {
        PreviewViewController *controller = (PreviewViewController *) segue.destinationViewController;
        controller.url = url;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
