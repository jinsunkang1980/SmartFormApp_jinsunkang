objc//
//  ViewController.h

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// Required Assignment Components
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UISwitch *subscribeSwitch;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UILabel *statusLabel;

// Bonus Components (Optional)
@property (nonatomic, strong) UIPickerView *languagePicker;
@property (nonatomic, strong) NSArray<NSString *> *languages;
@property (nonatomic, strong) UILabel *selectedLanguageLabel;

@end
