//
//  IntroductionViewController.m
//  TechRadar
//
//  Created by Magnus Ernstsson on 2012-10-25.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "IntroductionViewController.h"
#import "PreviewViewController.h"

@interface IntroductionViewController ()

@end

@implementation IntroductionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction) faq:(UIButton*)button {
    [self performSegueWithIdentifier:@"intro-to-preview" sender:@"http://martinfowler.com/articles/radar-faq.html"];
}

-(IBAction) radar:(UIButton*)button {
    [self performSegueWithIdentifier:@"intro-to-preview" sender:@"http://www.thoughtworks.com/radar"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSString*)url
{
	if ([segue.identifier isEqualToString:@"intro-to-preview"]) {
    	PreviewViewController *controller = (PreviewViewController*)segue.destinationViewController;
        controller.url = url;
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
