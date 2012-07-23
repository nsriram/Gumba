//
//  RadarItemDetailViewController.h
//  TechRadar
//
//  Created by Sriram Narasimhan on 23/07/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadarItemDetailViewController : UIViewController {
    IBOutlet UILabel *detail;
}
@property (nonatomic,strong) UILabel *detail;
-(IBAction) ok:(UIButton *)ok;
@end
