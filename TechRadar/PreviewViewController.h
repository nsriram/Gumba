//
//  PreviewViewController.h
//  TechRadar
//
//  Created by Magnus Ernstsson on 2012-10-24.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewViewController : UIViewController
-(IBAction) openInSafari:(id)selector;
@property (nonatomic,strong) IBOutlet UIWebView *webView;
@property NSString *url;

@end
