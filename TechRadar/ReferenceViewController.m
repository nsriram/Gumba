#import "ReferenceViewController.h"
#import "AppConstants.h"

@implementation ReferenceViewController
@synthesize referencesWebView,toolbar,backButton;

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

-(void) loadLocalFile {
    NSString *htmlFileContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"radar_references" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath] isDirectory:YES];
    [self.referencesWebView loadHTMLString:htmlFileContent baseURL:baseURL];
}

-(void) loadReferences {
    CGRect webViewFrame = self.referencesWebView.frame;
    [self.referencesWebView removeFromSuperview];
    self.referencesWebView.delegate = nil;
    self.referencesWebView = nil;
    self.referencesWebView = [[UIWebView alloc]initWithFrame:webViewFrame];
    self.referencesWebView.delegate = self;
    [self.view addSubview:self.referencesWebView];
    [self loadLocalFile];
}

-(IBAction) references:(UIBarButtonItem *)barButtonItem {
    [self loadReferences];
}

-(IBAction) back:(UIBarButtonItem *)barButtonItem {
    if ([self.referencesWebView canGoBack]) {
        [self.referencesWebView goBack];
    } else {
        [self loadReferences];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[AppConstants detailBackgroundColor]];
    [self.referencesWebView setBackgroundColor:[AppConstants detailBackgroundColor]];
    [self loadLocalFile];
    [self bindSwipeRight];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
@end