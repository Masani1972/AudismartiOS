//
//  RecuperarViewController.m
//  Audismart
//
//  Created by Dayana Martinez on 30-01-16.
//  Copyright © 2016 Audismart. All rights reserved.
//

#import "RecuperarViewController.h"
#import "Constantes.h"

@interface RecuperarViewController ()

@end

@implementation RecuperarViewController

@synthesize textFieldEmail;
@synthesize buttonEnviarContrasena;
@synthesize jsonParams;
UIAlertView *alert;
    
- (void)viewDidLoad {
    [super viewDidLoad];
    jsonParams = [[JsonParams alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    self.textFieldEmail.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonEnviarContrasena:(id)sender {

    NSURL *url = [NSURL URLWithString: [Constantes datos].urlServicios ];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config  delegate:self delegateQueue:nil];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *queryDictionary = @{ @"email": textFieldEmail.text, @"ACCION": @"RECUPERAR CONTRASENA"};
    
    NSString *params =[jsonParams createRequets:queryDictionary];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    NSLog(@"Response: %@ %@\n", response, error);
                                                    if(error == nil)
                                                    {
                                                        NSString *response =[[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                        NSDictionary *result = [jsonParams createResponseDictionary:response];
                                                        NSString *categoryString = [result[@"error"] stringValue];
                                                        if([categoryString isEqualToString:@"0"])
                                                        {
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [self success:result[@"message"]];
                                                            });
                                                        }else{
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [self error:result[@"message"]];
                                                            });
                                                        }
                                                    }
                                                }];
    [dataTask resume];
}

-(void)error:(NSString *)message{
    
    alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

-(void)success:(NSString *)message{
    alert = [[UIAlertView alloc] initWithTitle:@"Éxito"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //limit the size :
    int limit = 250;
    return !([textField.text length]>=limit && [string length] > range.length);
}
@end
