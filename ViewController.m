#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 200, 250, 50)];
    label.text = @"Welcome to SmartForm!";
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
}

@end