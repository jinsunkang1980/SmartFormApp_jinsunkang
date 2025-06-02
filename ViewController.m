//
//  ViewController.m
//  SmartFormApp
//
//  Created on Assignment
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up the view
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Smart Form";
    
    // Initialize programming languages array for bonus picker
    self.programmingLanguages = @[@"Swift", @"Objective-C", @"Java", @"Python", @"JavaScript", @"C++", @"C#", @"Ruby"];
    
    // Set up UI components
    [self setupUI];
    
    // Load saved data
    [self loadSavedData];
    
    // Add tap gesture to dismiss keyboard
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)setupUI {
    // Create and configure UI elements
    [self createNameTextField];
    [self createEmailTextField];
    [self createNewsletterSwitch];
    [self createLanguagePickerView];
    [self createSubmitButton];
    [self createValidationLabel];
    
    // Set up layout
    [self setupLayout];
}

- (void)createNameTextField {
    self.nameTextField = [[UITextField alloc] init];
    self.nameTextField.placeholder = @"Enter your name";
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTextField.delegate = self;
    self.nameTextField.returnKeyType = UIReturnKeyNext;
    self.nameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.nameTextField];
}

- (void)createEmailTextField {
    self.emailTextField = [[UITextField alloc] init];
    self.emailTextField.placeholder = @"Enter your email";
    self.emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailTextField.delegate = self;
    self.emailTextField.returnKeyType = UIReturnKeyDone;
    self.emailTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.emailTextField];
}

- (void)createNewsletterSwitch {
    // Create label for switch
    UILabel *switchLabel = [[UILabel alloc] init];
    switchLabel.text = @"Subscribe to Newsletter";
    switchLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:switchLabel];
    
    // Create switch
    self.newsletterSwitch = [[UISwitch alloc] init];
    self.newsletterSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.newsletterSwitch];
    
    // Layout for switch and label
    [NSLayoutConstraint activateConstraints:@[
        [switchLabel.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20],
        [switchLabel.topAnchor constraintEqualToAnchor:self.emailTextField.bottomAnchor constant:20],
        [self.newsletterSwitch.leadingAnchor constraintEqualToAnchor:switchLabel.trailingAnchor constant:10],
        [self.newsletterSwitch.centerYAnchor constraintEqualToAnchor:switchLabel.centerYAnchor],
        [self.newsletterSwitch.trailingAnchor constraintLessThanOrEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-20]
    ]];
}

- (void)createLanguagePickerView {
    // Create label for picker
    UILabel *pickerLabel = [[UILabel alloc] init];
    pickerLabel.text = @"Favorite Programming Language";
    pickerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:pickerLabel];
    
    // Create picker view
    self.languagePickerView = [[UIPickerView alloc] init];
    self.languagePickerView.delegate = self;
    self.languagePickerView.dataSource = self;
    self.languagePickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.languagePickerView];
    
    // Layout for picker and label
    [NSLayoutConstraint activateConstraints:@[
        [pickerLabel.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20],
        [pickerLabel.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-20],
        [pickerLabel.topAnchor constraintEqualToAnchor:self.newsletterSwitch.bottomAnchor constant:20],
        [self.languagePickerView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20],
        [self.languagePickerView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-20],
        [self.languagePickerView.topAnchor constraintEqualToAnchor:pickerLabel.bottomAnchor constant:10],
        [self.languagePickerView.heightAnchor constraintEqualToConstant:120]
    ]];
}

- (void)createSubmitButton {
    self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    self.submitButton.backgroundColor = [UIColor systemBlueColor];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitButton.layer.cornerRadius = 8;
    self.submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.submitButton addTarget:self action:@selector(submitButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.submitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.submitButton];
}

- (void)createValidationLabel {
    self.validationLabel = [[UILabel alloc] init];
    self.validationLabel.text = @"";
    self.validationLabel.textAlignment = NSTextAlignmentCenter;
    self.validationLabel.numberOfLines = 0;
    self.validationLabel.font = [UIFont systemFontOfSize:14];
    self.validationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.validationLabel];
}

- (void)setupLayout {
    [NSLayoutConstraint activateConstraints:@[
        // Name TextField
        [self.nameTextField.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20],
        [self.nameTextField.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20],
        [self.nameTextField.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-20],
        [self.nameTextField.heightAnchor constraintEqualToConstant:44],
        
        // Email TextField
        [self.emailTextField.topAnchor constraintEqualToAnchor:self.nameTextField.bottomAnchor constant:20],
        [self.emailTextField.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20],
        [self.emailTextField.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-20],
        [self.emailTextField.heightAnchor constraintEqualToConstant:44],
        
        // Submit Button
        [self.submitButton.topAnchor constraintEqualToAnchor:self.languagePickerView.bottomAnchor constant:30],
        [self.submitButton.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20],
        [self.submitButton.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-20],
        [self.submitButton.heightAnchor constraintEqualToConstant:50],
        
        // Validation Label
        [self.validationLabel.topAnchor constraintEqualToAnchor:self.submitButton.bottomAnchor constant:20],
        [self.validationLabel.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20],
        [self.validationLabel.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-20]
    ]];
}

#pragma mark - Actions

- (void)submitButtonTapped:(UIButton *)sender {
    NSString *name = self.nameTextField.text;
    NSString *email = self.emailTextField.text;
    
    // Validate input
    if ([self validateInput:name email:email]) {
        // Save data
        [self saveFormData];
        
        // Show success message
        NSString *selectedLanguage = self.programmingLanguages[[self.languagePickerView selectedRowInComponent:0]];
        NSString *subscriptionStatus = self.newsletterSwitch.isOn ? @"subscribed to" : @"not subscribed to";
        
        self.validationLabel.textColor = [UIColor systemGreenColor];
        self.validationLabel.text = [NSString stringWithFormat:@"✅ Success! Welcome %@!\nEmail: %@\nFavorite Language: %@\nNewsletter: %@ newsletter", name, email, selectedLanguage, subscriptionStatus];
        
        NSLog(@"Form submitted successfully - Name: %@, Email: %@, Language: %@, Newsletter: %@", 
              name, email, selectedLanguage, self.newsletterSwitch.isOn ? @"Yes" : @"No");
    }
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - Validation

- (BOOL)validateInput:(NSString *)name email:(NSString *)email {
    // Check if name is empty
    if (!name || name.length == 0) {
        [self showValidationError:@"❌ Name cannot be empty"];
        return NO;
    }
    
    // Check if email is empty
    if (!email || email.length == 0) {
        [self showValidationError:@"❌ Email cannot be empty"];
        return NO;
    }
    
    // Check if email contains @ and .
    if (![email containsString:@"@"] || ![email containsString:@"."]) {
        [self showValidationError:@"❌ Please enter a valid email address"];
        return NO;
    }
    
    // Additional email validation
    NSRange atRange = [email rangeOfString:@"@"];
    NSRange dotRange = [email rangeOfString:@"." options:NSBackwardsSearch];
    
    if (atRange.location == NSNotFound || dotRange.location == NSNotFound || 
        atRange.location >= dotRange.location || atRange.location == 0 || 
        dotRange.location == email.length - 1) {
        [self showValidationError:@"❌ Please enter a valid email address"];
        return NO;
    }
    
    return YES;
}

- (void)showValidationError:(NSString *)message {
    self.validationLabel.textColor = [UIColor systemRedColor];
    self.validationLabel.text = message;
}

#pragma mark - Data Persistence (Bonus)

- (void)saveFormData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.nameTextField.text forKey:@"savedName"];
    [defaults setObject:self.emailTextField.text forKey:@"savedEmail"];
    [defaults setBool:self.newsletterSwitch.isOn forKey:@"savedNewsletterSubscription"];
    [defaults setInteger:[self.languagePickerView selectedRowInComponent:0] forKey:@"savedLanguageIndex"];
    [defaults synchronize];
}

- (void)loadSavedData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *savedName = [defaults stringForKey:@"savedName"];
    NSString *savedEmail = [defaults stringForKey:@"savedEmail"];
    BOOL savedNewsletterSubscription = [defaults boolForKey:@"savedNewsletterSubscription"];
    NSInteger savedLanguageIndex = [defaults integerForKey:@"savedLanguageIndex"];
    
    if (savedName) {
        self.nameTextField.text = savedName;
    }
    
    if (savedEmail) {
        self.emailTextField.text = savedEmail;
    }
    
    self.newsletterSwitch.on = savedNewsletterSubscription;
    
    if (savedLanguageIndex >= 0 && savedLanguageIndex < self.programmingLanguages.count) {
        [self.languagePickerView selectRow:savedLanguageIndex inComponent:0 animated:NO];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameTextField) {
        [self.emailTextField becomeFirstResponder];
    } else if (textField == self.emailTextField) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // Clear validation message when user starts typing
    if (self.validationLabel.text.length > 0) {
        self.validationLabel.text = @"";
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.programmingLanguages.count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.programmingLanguages[row];
}

#pragma mark - Dark Mode Support (Bonus)

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    if (@available(iOS 13.0, *)) {
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            // Update UI for dark mode
            [self updateUIForCurrentTraitCollection];
        }
    }
}

- (void)updateUIForCurrentTraitCollection {
    if (@available(iOS 13.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            // Dark mode customizations
            self.submitButton.backgroundColor = [UIColor systemIndigoColor];
        } else {
            // Light mode customizations
            self.submitButton.backgroundColor = [UIColor systemBlueColor];
        }
    }
}

@end
