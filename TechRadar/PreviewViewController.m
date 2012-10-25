//
//  PreviewViewController.m
//  TechRadar
//
//  Created by Magnus Ernstsson on 2012-10-24.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "PreviewViewController.h"

@implementation PreviewViewController
@synthesize url;

-(IBAction) openInSafari:(id)selector {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
}

- (IBAction)dismissDetails:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *nsurl = [NSURL URLWithString:self.url];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:nsurl];
    [self.webView loadRequest:requestObj];
}

@end
