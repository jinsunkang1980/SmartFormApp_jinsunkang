//
//  ViewController.h
//  SmartFormApp
//
//  Created on Assignment
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

// UI Components
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UITextField *emailTextField;
@property (strong, nonatomic) UISwitch *newsletterSwitch;
@property (strong, nonatomic) UIButton *submitButton;
@property (strong, nonatomic) UILabel *validationLabel;
@property (strong, nonatomic) UIPickerView *languagePickerView;

// Data
@property (strong, nonatomic) NSArray *programmingLanguages;

@end
