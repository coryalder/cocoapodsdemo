//
//  MasterViewController.m
//  CocoaPodsDemo
//
//  Created by Cory Alder on 2014-10-17.
//  Copyright (c) 2014 Davander Mobile Corporation. All rights reserved.
//

#import "MasterViewController.h"
#import "CNPPopupController.h"
#import "SCLAlertView.h"
#import "FSLineChart.h"


@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.objects = [@[@"CNPPopupController", @"SCLAlertView", @"FSLineChart"] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSString *object = self.objects[indexPath.row];
    cell.textLabel.text = object;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) { // show pod 1
        
        NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:@"OK"];
        
        CNPPopupButtonItem *button = [CNPPopupButtonItem defaultButtonItemWithTitle:buttonTitle backgroundColor:[UIColor lightGrayColor]];
        
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"Important Popup"];
        
        CNPPopupController *popup = [[CNPPopupController alloc] initWithTitle:title
                                                                     contents:@[[UIImage imageNamed:@"kitten"]]
                                                                  buttonItems:@[button]
                                                        destructiveButtonItem:nil];
        popup.theme = [CNPPopupTheme defaultTheme];
        
        button.selectionHandler = ^(CNPPopupButtonItem *item){
            [popup dismissPopupControllerAnimated:YES];
        };
        
        [popup presentPopupControllerAnimated:YES];
    } else if (indexPath.row == 1) { // show pod 2
    
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showSuccess:self title:@"Hello World" subTitle:@"This is a more descriptive text." closeButtonTitle:@"Done" duration:0.0f];

        
    } else if (indexPath.row == 2) { // show pod 3
        
        
        NSArray* months = @[@"January", @"February", @"March", @"April", @"May", @"June", @"July"];
        NSArray *chartData = @[@(18.9),@(13.9),@(112.0), @(100.00), @(86.5), @(46.3), @(46.5)];
        
        FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(20, 260, [UIScreen mainScreen].bounds.size.width - 40, 166)];
        
        lineChart.labelForIndex = ^(NSUInteger item) {
            return months[item];
        };
        
        lineChart.labelForValue = ^(CGFloat value) {
            return [NSString stringWithFormat:@"%.02f €", powf(10,value)];
        };
        
        [lineChart setChartData:chartData];
        
        
        UIViewController *viewController = [[UIViewController alloc] init];
        
        [viewController.view addSubview:lineChart];
        [viewController.view setBackgroundColor:[UIColor whiteColor]];
        
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
}

@end
