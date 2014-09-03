//
//  ViewController.m
//  jancode
//
//  Created by 加藤 周 on 2014/08/27.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "ViewController.h"

#import "afirietoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>


@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>{
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;
    UIView *_highlightView;
    IBOutlet UIView *barcodeView;
    
    
    
}

@property (weak, nonatomic) IBOutlet UIView *barcodeView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    filed.delegate = self;
    
    
    getBarcodeString = nil;
    [self barcodeCap];
    
    
    
    
    number = 0;
    number = number + 1;
    if (number >1) {
        barcodeView.hidden = YES;
    }
    
    //    barcodeView.transform = CGAffineTransformMakeRotation(M_PI/2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    

    
    // キーボードを閉じる
    [sender resignFirstResponder];
    
    return TRUE;
}



-(IBAction)kensaku{
    

    
    a= 1;
    kiwado = filed.text;
    get = kiwado;
    svStr1 = get;
    

    
    afirietoViewController *bview = [self.storyboard instantiateViewControllerWithIdentifier:@"b"];
    [self presentViewController:bview animated:YES completion:nil];
    
    
    afirietoViewController *secondViewController = [[afirietoViewController alloc] init];

}




-(void)barcodeCap{
    
    
    
    _highlightView = [[UIView alloc] init];
    _highlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _highlightView.layer.borderColor = [UIColor redColor].CGColor;
    _highlightView.layer.borderWidth = 3;
    [self.barcodeView addSubview:_highlightView];
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error: %@", error);
    }
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];
    
    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
    
    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = self.barcodeView.bounds;
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.barcodeView.layer addSublayer:_prevLayer];
    AVCaptureConnection *con = _prevLayer.connection;
    //    con.videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
    
    [_session startRunning];
    [self.barcodeView bringSubviewToFront:_highlightView];
    
    
    
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    
    
    a = 2;
    
    
    
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type]){
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                
                
                
                
                break;
            }
        }
        
        if (detectionString != nil){
            NSLog(@"読み込んだのは%@",detectionString);
            
            

            
            
            
            
            AudioServicesPlaySystemSound(1000);
            
            NSLog(@"オーーイore");
            getBarcodeString = detectionString;
            
            svStr = getBarcodeString;
            
 
            
            
            afirietoViewController *secondViewController = [[afirietoViewController alloc] init];
//            [afirietoViewController setSvStr:tf.text];
            

            
            
            
            
            
            afirietoViewController *bview = [self.storyboard instantiateViewControllerWithIdentifier:@"b"];
            [self presentViewController:bview animated:YES completion:nil];
            
            
            

            
            barcodeView.hidden = YES;
            
           
            
            
            
            
            //値が入ったら、画面遷移
            
            
            
            
            
            
            
            
            
            
            
            
            break;
            
            
        }
    }
    _highlightView.frame = highlightViewRect;
}




@end
