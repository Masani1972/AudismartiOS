//
//  RegistroEmpresa.m
//  Aosmart
//
//  Created by Raúl Gómez on 7/07/16.
//  Copyright © 2016 Audismart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistroEmpresa.h"

@interface RegistroEmpresa ()

@end

@implementation RegistroEmpresa
@synthesize textDepartamento;
@synthesize pickerDepartamento;
NSArray *_pickerData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.textDepartamento.delegate = self;
    // Initialize Data
    
    _pickerData = @[@"Seleccione Uno",
                    @"Medellín",
                    @"Abejorral",
                    @"Abriaquí",
                    @"Alejandría",
                    @"Amagá",
                    @"Amalfi"];
    
    pickerDepartamento.hidden=YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //self.demoLabel.text = [NSString stringWithFormat:@"selected row: %d", row];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    pickerDepartamento.delegate = self;
    pickerDepartamento.dataSource = self;
    pickerDepartamento.showsSelectionIndicator = YES;
    [self.view addSubview:pickerDepartamento];
    pickerDepartamento.hidden=NO;
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}
@end