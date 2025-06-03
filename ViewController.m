objc//
//  ViewController.m

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SmartForm";
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    [self setupScrollView];
    [self setupUI];
    [self setupKeyboardDismissal];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self saveFormData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self restoreFormData];
}

- (void)setupScrollView {
    // Add scroll view for better layout on smaller screens
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scrollView];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.contentView];
    
    // Set up constraints
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        
        [self.contentView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
        [self.contentView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor]
    ]];
}

- (void)setupUI {
    CGFloat padding = 20;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 2 * padding;
    CGFloat y = 30;

    // Name Field (Required)
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 25)];
    nameLabel.text = @"Name *";
    nameLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:nameLabel];
    y += 30;

    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(padding, y, width, 40)];
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameField.placeholder = @"Enter your name";
    self.nameField.delegate = self;
    self.nameField.returnKeyType = UIReturnKeyNext;
    [self.contentView addSubview:self.nameField];
    y += 60;

    // Email Field (Required)
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 25)];
    emailLabel.text = @"Email *";
    emailLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:emailLabel];
    y += 30;

    self.emailField = [[UITextField alloc] initWithFrame:CGRectMake(padding, y, width, 40)];
    self.emailField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailField.placeholder = @"Enter your email";
    self.emailField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailField.delegate = self;
    self.emailField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:self.emailField];
    y += 70;

    // Newsletter Switch (Required)
    UILabel *subscribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width - 80, 30)];
    subscribeLabel.text = @"Subscribe to newsletter";
    subscribeLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:subscribeLabel];

    self.subscribeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(width - 30, y, 0, 0)];
    [self.contentView addSubview:self.subscribeSwitch];
    y += 70;

    // Programming Language Picker (Bonus)
    UILabel *languageLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 25)];
    languageLabel.text = @"Favorite Programming Language";
    languageLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:languageLabel];
    y += 30;

    self.languages = @[@"Swift", @"Objective-C", @"Java", @"Python", @"JavaScript"];
    self.languagePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(padding, y, width, 120)];
    self.languagePicker.dataSource = self;
    self.languagePicker.delegate = self;
    [self.contentView addSubview:self.languagePicker];
    y += 130;

    self.selectedLanguageLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 25)];
    self.selectedLanguageLabel.text = @"Selected: Swift";
    self.selectedLanguageLabel.textColor = [UIColor systemBlueColor];
    [self.contentView addSubview:self.selectedLanguageLabel];
    y += 50;

    // Submit Button (Required)
    self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.submitButton.frame = CGRectMake(padding, y, width, 50);
    [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitButton.backgroundColor = [UIColor systemBlueColor];
    self.submitButton.layer.cornerRadius = 8;
    self.submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.submitButton addTarget:self action:@selector(handleSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.submitButton];
    y += 70;

    // Status Label (Required)
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 80)];
    self.statusLabel.numberOfLines = 0;
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.statusLabel];
    y += 100;

    // Set scroll view content size
    self.scrollView.contentSize = CGSizeMake(width + 2 * padding, y);
}

- (void)setupKeyboardDismissal {
    // Dismiss keyboard on tap (Assignment Requirement)
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)handleSubmit {
    NSString *name = [self.nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    // Assignment Validation Requirements:
    // 1. Name and email must not be empty
    // 2. Email must contain @ and .
    
    if (name.length == 0 || email.length == 0) {
        self.statusLabel.textColor = [UIColor systemRedColor];
        self.statusLabel.text = @"Please fill in all required fields.";
        return;
    }

    if (![email containsString:@"@"] || ![email containsString:@"."]) {
        self.statusLabel.textColor = [UIColor systemRedColor];
        self.statusLabel.text = @"Invalid email format.";
        return;
    }

    // Success Message (Assignment Requirement)
    NSString *subscribeText = self.subscribeSwitch.isOn ? @"Subscribed to newsletter." : @"Not subscribed.";
    NSString *selectedLanguage = self.languages[[self.languagePicker selectedRowInComponent:0]];
    
    self.statusLabel.textColor = [UIColor systemGreenColor];
    self.statusLabel.text = [NSString stringWithFormat:@"Thank you, %@!\n%@\nFavorite Language: %@", name, subscribeText, selectedLanguage];
    
    // Clear saved data after successful submission
    [self clearSavedFormData];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate (Assignment Requirement)

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameField) {
        [self.emailField becomeFirstResponder];
    } else if (textField == self.emailField) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - UIPickerView DataSource & Delegate (Bonus)

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.languages.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.languages[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedLanguageLabel.text = [NSString stringWithFormat:@"Selected: %@", self.languages[row]];
}

#pragma mark - NSUserDefaults Save/Restore (Bonus)

- (void)saveFormData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.nameField.text forKey:@"savedName"];
    [defaults setObject:self.emailField.text forKey:@"savedEmail"];
    [defaults setBool:self.subscribeSwitch.isOn forKey:@"savedSubscribe"];
    [defaults setInteger:[self.languagePicker selectedRowInComponent:0] forKey:@"savedLanguage"];
    
    [defaults synchronize];
}

- (void)restoreFormData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"savedName"] != nil) {
        self.nameField.text = [defaults stringForKey:@"savedName"];
        self.emailField.text = [defaults stringForKey:@"savedEmail"];
        self.subscribeSwitch.on = [defaults boolForKey:@"savedSubscribe"];
        
        NSInteger savedLanguage = [defaults integerForKey:@"savedLanguage"];
        if (savedLanguage >= 0 && savedLanguage < self.languages.count) {
            [self.languagePicker selectRow:savedLanguage inComponent:0 animated:NO];
            self.selectedLanguageLabel.text = [NSString stringWithFormat:@"Selected: %@", self.languages[savedLanguage]];
        }
    }
}

- (void)clearSavedFormData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *keysToRemove = @[@"savedName", @"savedEmail", @"savedSubscribe", @"savedLanguage"];
    
    for (NSString *key in keysToRemove) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
}

@end
