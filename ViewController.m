//
//  ViewController.m

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
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
    [self setupKeyboardHandling];
    
    NSLog(@"📋 ViewController loaded successfully on VMware!");
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
    // Simplified scroll view for VMware performance
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.bounces = NO; // Reduce animations for VMware
    [self.view addSubview:self.scrollView];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.contentView];
    
    // Use constraints for proper layout
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

    // Name Field (Required) ✅
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 25)];
    nameLabel.text = @"Name *";
    nameLabel.font = [UIFont boldSystemFontOfSize:16];
    nameLabel.textColor = [UIColor labelColor];
    [self.contentView addSubview:nameLabel];
    y += 30;

    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(padding, y, width, 44)];
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameField.placeholder = @"Enter your name";
    self.nameField.delegate = self;
    self.nameField.returnKeyType = UIReturnKeyNext;
    self.nameField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.contentView addSubview:self.nameField];
    y += 60;

    // Email Field (Required) ✅
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 25)];
    emailLabel.text = @"Email *";
    emailLabel.font = [UIFont boldSystemFontOfSize:16];
    emailLabel.textColor = [UIColor labelColor];
    [self.contentView addSubview:emailLabel];
    y += 30;

    self.emailField = [[UITextField alloc] initWithFrame:CGRectMake(padding, y, width, 44)];
    self.emailField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailField.placeholder = @"Enter your email";
    self.emailField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.emailField.delegate = self;
    self.emailField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:self.emailField];
    y += 70;

    // Newsletter Switch (Required) ✅
    UILabel *subscribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width - 80, 30)];
    subscribeLabel.text = @"Subscribe to newsletter";
    subscribeLabel.font = [UIFont systemFontOfSize:16];
    subscribeLabel.textColor = [UIColor labelColor];
    [self.contentView addSubview:subscribeLabel];

    self.subscribeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(width - 30, y, 0, 0)];
    [self.contentView addSubview:self.subscribeSwitch];
    y += 70;

    // Programming Language Segment (Bonus - VMware Optimized) ✅
    UILabel *languageLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 25)];
    languageLabel.text = @"Favorite Programming Language";
    languageLabel.font = [UIFont boldSystemFontOfSize:16];
    languageLabel.textColor = [UIColor labelColor];
    [self.contentView addSubview:languageLabel];
    y += 30;

    // Use SegmentedControl instead of PickerView for better VMware performance
    self.languageSegment = [[UISegmentedControl alloc] initWithItems:@[@"Swift", @"Objective-C", @"Java", @"Python"]];
    self.languageSegment.frame = CGRectMake(padding, y, width, 32);
    self.languageSegment.selectedSegmentIndex = 1; // Default to Objective-C
    [self.languageSegment addTarget:self action:@selector(languageChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.languageSegment];
    y += 50;

    self.selectedLanguageLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 25)];
    self.selectedLanguageLabel.text = @"Selected: Objective-C";
    self.selectedLanguageLabel.textColor = [UIColor systemBlueColor];
    self.selectedLanguageLabel.font = [UIFont systemFontOfSize:14];
    self.selectedLanguageLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.selectedLanguageLabel];
    y += 50;

    // Submit Button (Required) ✅
    self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.submitButton.frame = CGRectMake(padding, y, width, 50);
    [self.submitButton setTitle:@"Submit Form" forState:UIControlStateNormal];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitButton.backgroundColor = [UIColor systemBlueColor];
    self.submitButton.layer.cornerRadius = 8;
    self.submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.submitButton addTarget:self action:@selector(handleSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.submitButton];
    y += 70;

    // Status Label (Required) ✅
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 100)];
    self.statusLabel.numberOfLines = 0;
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.font = [UIFont systemFontOfSize:14];
    self.statusLabel.textColor = [UIColor labelColor];
    [self.contentView addSubview:self.statusLabel];
    y += 120;

    // Set scroll view content size
    [self.scrollView setContentSize:CGSizeMake(width + 2 * padding, y)];
}

- (void)setupKeyboardHandling {
    // Keyboard handling for VMware
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    // Tap gesture to dismiss keyboard
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)languageChanged:(UISegmentedControl *)segment {
    NSString *selectedLanguage = [segment titleForSegmentAtIndex:segment.selectedSegmentIndex];
    self.selectedLanguageLabel.text = [NSString stringWithFormat:@"Selected: %@", selectedLanguage];
    NSLog(@"💻 Language changed to: %@", selectedLanguage);
}

- (void)handleSubmit {
    NSString *name = [self.nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    NSLog(@"🔄 Form submission attempted on VMware");
    NSLog(@"👤 Name: %@", name);
    NSLog(@"📧 Email: %@", email);

    // Assignment Validation Requirements ✅
    if (name.length == 0 || email.length == 0) {
        [self showError:@"Please fill in all required fields."];
        return;
    }

    if (![email containsString:@"@"] || ![email containsString:@"."]) {
        [self showError:@"Invalid email format."];
        return;
    }

    // Success Message ✅
    NSString *subscribeText = self.subscribeSwitch.isOn ? @"Subscribed to newsletter ✅" : @"Not subscribed";
    NSString *selectedLanguage = [self.languageSegment titleForSegmentAtIndex:self.languageSegment.selectedSegmentIndex];
    
    [self showSuccess:[NSString stringWithFormat:@"✅ Thank you, %@!\n\n%@\nFavorite Language: %@", 
                      name, subscribeText, selectedLanguage]];
    
    [self clearSavedFormData];
    
    NSLog(@"✅ Form submitted successfully on VMware!");
    NSLog(@"📰 Newsletter: %@", subscribeText);
    NSLog(@"💻 Language: %@", selectedLanguage);
}

- (void)showError:(NSString *)message {
    self.statusLabel.textColor = [UIColor systemRedColor];
    self.statusLabel.text = [NSString stringWithFormat:@"❌ %@", message];
    NSLog(@"❌ Validation error: %@", message);
}

- (void)showSuccess:(NSString *)message {
    self.statusLabel.textColor = [UIColor systemGreenColor];
    self.statusLabel.text = message;
    
    // Scroll to show success message
    CGRect statusFrame = self.statusLabel.frame;
    [self.scrollView scrollRectToVisible:statusFrame animated:YES];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextFieldDelegate (Required) ✅

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameField) {
        [self.emailField becomeFirstResponder];
    } else if (textField == self.emailField) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - NSUserDefaults Save/Restore (Bonus) ✅

- (void)saveFormData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.nameField.text forKey:@"savedName"];
    [defaults setObject:self.emailField.text forKey:@"savedEmail"];
    [defaults setBool:self.subscribeSwitch.isOn forKey:@"savedSubscribe"];
    [defaults setInteger:self.languageSegment.selectedSegmentIndex forKey:@"savedLanguage"];
    
    [defaults synchronize];
    NSLog(@"💾 Form data saved to NSUserDefaults on VMware");
}

- (void)restoreFormData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"savedName"] != nil) {
        self.nameField.text = [defaults stringForKey:@"savedName"];
        self.emailField.text = [defaults stringForKey:@"savedEmail"];
        self.subscribeSwitch.on = [defaults boolForKey:@"savedSubscribe"];
        
        NSInteger savedLanguage = [defaults integerForKey:@"savedLanguage"];
        if (savedLanguage >= 0 && savedLanguage < self.languageSegment.numberOfSegments) {
            self.languageSegment.selectedSegmentIndex = savedLanguage;
            [self languageChanged:self.languageSegment];
        }
        
        NSLog(@"📂 Form data restored from NSUserDefaults on VMware");
    }
}

- (void)clearSavedFormData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *keysToRemove = @[@"savedName", @"savedEmail", @"savedSubscribe", @"savedLanguage"];
    
    for (NSString *key in keysToRemove) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
    NSLog(@"🗑️ Saved form data cleared on VMware");
}

@end
