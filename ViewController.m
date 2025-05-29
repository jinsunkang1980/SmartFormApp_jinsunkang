#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UISwitch *subscribeSwitch;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UIPickerView *languagePicker;
@property (nonatomic, strong) NSArray<NSString *> *languages;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    self.title = @"SmartForm";

    self.languages = @[@"Objective‑C", @"Swift", @"Java", @"Kotlin", @"C#"];

    [self setupUI];
    [self restoreFormData];
}

- (void)setupUI {
    _nameField = [self createTextFieldWithPlaceholder:@"Name"];
    _emailField = [self createTextFieldWithPlaceholder:@"Email"];
    _emailField.keyboardType = UIKeyboardTypeEmailAddress;

    UILabel *subscribeLabel = [[UILabel alloc] init];
    subscribeLabel.text = @"Subscribe to newsletter";
    subscribeLabel.translatesAutoresizingMaskIntoConstraints = NO;

    _subscribeSwitch = [[UISwitch alloc] init];
    _subscribeSwitch.translatesAutoresizingMaskIntoConstraints = NO;

    _languagePicker = [[UIPickerView alloc] init];
    _languagePicker.dataSource = self;
    _languagePicker.delegate = self;
    _languagePicker.translatesAutoresizingMaskIntoConstraints = NO;

    _submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    _submitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_submitButton addTarget:self action:@selector(submitTapped) forControlEvents:UIControlEventTouchUpInside];
    _submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];

    _messageLabel = [[UILabel alloc] init];
    _messageLabel.textColor = UIColor.systemRedColor;
    _messageLabel.numberOfLines = 0;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:_nameField];
    [self.view addSubview:_emailField];
    [self.view addSubview:subscribeLabel];
    [self.view addSubview:_subscribeSwitch];
    [self.view addSubview:_languagePicker];
    [self.view addSubview:_submitButton];
    [self.view addSubview:_messageLabel];

    UILayoutGuide *g = self.view.safeAreaLayoutGuide;
    CGFloat padding = 20.0;

    [NSLayoutConstraint activateConstraints:@[
        [_nameField.topAnchor constraintEqualToAnchor:g.topAnchor constant:padding],
        [_nameField.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:padding],
        [_nameField.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-padding],
        [_nameField.heightAnchor constraintEqualToConstant:44],

        [_emailField.topAnchor constraintEqualToAnchor:_nameField.bottomAnchor constant:padding],
        [_emailField.leadingAnchor constraintEqualToAnchor:_nameField.leadingAnchor],
        [_emailField.trailingAnchor constraintEqualToAnchor:_nameField.trailingAnchor],
        [_emailField.heightAnchor constraintEqualToConstant:44],

        [subscribeLabel.topAnchor constraintEqualToAnchor:_emailField.bottomAnchor constant:padding],
        [subscribeLabel.leadingAnchor constraintEqualToAnchor:_nameField.leadingAnchor],

        [_subscribeSwitch.centerYAnchor constraintEqualToAnchor:subscribeLabel.centerYAnchor],
        [_subscribeSwitch.trailingAnchor constraintEqualToAnchor:_nameField.trailingAnchor],

        [_languagePicker.topAnchor constraintEqualToAnchor:subscribeLabel.bottomAnchor constant:padding],
        [_languagePicker.leadingAnchor constraintEqualToAnchor:_nameField.leadingAnchor],
        [_languagePicker.trailingAnchor constraintEqualToAnchor:_nameField.trailingAnchor],
        [_languagePicker.heightAnchor constraintEqualToConstant:120],

        [_submitButton.topAnchor constraintEqualToAnchor:_languagePicker.bottomAnchor constant:padding],
        [_submitButton.centerXAnchor constraintEqualToAnchor:g.centerXAnchor],

        [_messageLabel.topAnchor constraintEqualToAnchor:_submitButton.bottomAnchor constant:padding],
        [_messageLabel.leadingAnchor constraintEqualToAnchor:_nameField.leadingAnchor],
        [_messageLabel.trailingAnchor constraintEqualToAnchor:_nameField.trailingAnchor]
    ]];
}

- (UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder {
    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = placeholder;
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.translatesAutoresizingMaskIntoConstraints = NO;
    tf.delegate = self;
    return tf;
}

#pragma mark - Actions
- (void)submitTapped {
    [self.view endEditing:YES];
    NSString *name = _nameField.text;
    NSString *email = _emailField.text;

    if (name.length == 0 || email.length == 0) {
        _messageLabel.text = @"Name and email are required.";
        _messageLabel.textColor = UIColor.systemRedColor;
        return;
    }
    if (![email containsString:@"@"] || ![email containsString:@"."]) {
        _messageLabel.text = @"Enter a valid email address.";
        _messageLabel.textColor = UIColor.systemRedColor;
        return;
    }

    // Save form data
    [self persistFormData];

    NSString *selectedLang = self.languages[[self.languagePicker selectedRowInComponent:0]];
    NSString *status = _subscribeSwitch.isOn ? @"subscribed" : @"not subscribed";

    _messageLabel.textColor = UIColor.systemGreenColor;
    _messageLabel.text = [NSString stringWithFormat:@"Success! Hi %@, you chose %@ and are %@.", name, selectedLang, status];
}

#pragma mark - Persistence
- (void)persistFormData {
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    [defaults setObject:_nameField.text forKey:@"name"];
    [defaults setObject:_emailField.text forKey:@"email"];
    [defaults setBool:_subscribeSwitch.isOn forKey:@"subscribe"];
    [defaults setInteger:[_languagePicker selectedRowInComponent:0] forKey:@"languageIndex"];
    [defaults synchronize];
}

- (void)restoreFormData {
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    _nameField.text = [defaults stringForKey:@"name"] ?: @"";
    _emailField.text = [defaults stringForKey:@"email"] ?: @"";
    _subscribeSwitch.on = [defaults boolForKey:@"subscribe"];
    NSInteger idx = [defaults integerForKey:@"languageIndex"];
    if (idx < self.languages.count) {
        [_languagePicker selectRow:idx inComponent:0 animated:NO];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _nameField) {
        [_emailField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - UIPickerViewDataSource / Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.languages.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.languages[row];
}

@end
