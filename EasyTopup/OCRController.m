//
//  OCRController.m
//  Template Framework Project
//
//  Created by Eeposit1 on 12/3/15.
//  Copyright © 2015 Daniele Galiotto - www.g8production.com. All rights reserved.
//

#import "OCRController.h"
@interface OCRController()
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@end
@implementation OCRController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create a queue to perform recognition operations
    self.operationQueue = [[NSOperationQueue alloc] init];
    [self openCamera];
    _activityIndicator.hidesWhenStopped = YES;
    [self processingStateWithStatusMessage:@""];
    [self setNavigationBar];
}

- (void)setNavigationBar {
    UIBarButtonItem *saveButton       = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    self.navigationItem.rightBarButtonItems = @[saveButton, addButton];
}

- (void)saveAction {
    [self showAlert];
}

-(void)recognizeImageWithTesseract:(UIImage *)image
{
    // Animate a progress activity indicator
    
    // Create a new `G8RecognitionOperation` to perform the OCR asynchronously
    // It is assumed that there is a .traineddata file for the language pack
    // you want Tesseract to use in the "tessdata" folder in the root of the
    // project AND that the "tessdata" folder is a referenced folder and NOT
    // a symbolic group in your project
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] initWithLanguage:@"eng"];
    
    // Use the original Tesseract engine mode in performing the recognition
    // (see G8Constants.h) for other engine mode options
    operation.tesseract.engineMode = G8OCREngineModeTesseractCubeCombined;
    
    // Let Tesseract automatically segment the page into blocks of text
    // based on its analysis (see G8Constants.h) for other page segmentation
    // mode options
    operation.tesseract.pageSegmentationMode = G8PageSegmentationModeAutoOnly;
    
    // Optionally limit the time Tesseract should spend performing the
    // recognition
    //operation.tesseract.maximumRecognitionTime = 1.0;
    
    // Set the delegate for the recognition to be this class
    // (see `progressImageRecognitionForTesseract` and
    // `shouldCancelImageRecognitionForTesseract` methods below)
    operation.delegate = self;
    
    // Optionally limit Tesseract's recognition to the following whitelist
    // and blacklist of characters
    //operation.tesseract.charWhitelist = @"01234";
    //operation.tesseract.charBlacklist = @"56789";
    
    // Set the image on which Tesseract should perform recognition
    operation.tesseract.image = image;
    
    // Optionally limit the region in the image on which Tesseract should
    // perform recognition to a rectangle
    //operation.tesseract.rect = CGRectMake(20, 20, 100, 100);
    
    // Specify the function block that should be executed when Tesseract
    // finishes performing recognition on the image
    operation.recognitionCompleteBlock = ^(G8Tesseract *tesseract) {
        // Fetch the recognized text
        NSString *recognizedText = tesseract.recognizedText;
        NSLog(@"Recognized Text %@",recognizedText);
//        [self filterText:recognizedText];
    };
    
    // Display the image to be recognized in the view
    self.imageView.image = operation.tesseract.thresholdedImage;
    
    // Finally, add the recognition operation to the queue
    [self.operationQueue addOperation:operation];
}
/**
 *  This function is part of Tesseract's delegate. It will be called
 *  periodically as the recognition happens so you can observe the progress.
 *
 *  @param tesseract The `G8Tesseract` object performing the recognition.
 */
- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}

/**
 *  This function is part of Tesseract's delegate. It will be called
 *  periodically as the recognition happens so you can cancel the recogntion
 *  prematurely if necessary.
 *
 *  @param tesseract The `G8Tesseract` object performing the recognition.
 *
 *  @return Whether or not to cancel the recognition.
 */
- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    return NO;  // return YES, if you need to cancel recognition prematurely
}

- (void)openCamera {
    UIImagePickerController *imgPicker = [UIImagePickerController new];
    imgPicker.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imgPicker animated:YES completion:nil];
    }
}


- (IBAction)clearCache:(id)sender
{
    [G8Tesseract clearCache];
}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    _imageView.image = image;
    
    ImageCropViewController *controller = [[ImageCropViewController alloc] initWithImage:image];
    controller.delegate = self;
    controller.blurredBackground = YES;
    [self.navigationController pushViewController:controller animated:YES];

    
    [self processingStateWithStatusMessage:@"Preparing For Crop"];
}

- (void)ImageCropViewController:(ImageCropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage{
    _croppedImage = croppedImage;
    _imageView.image = croppedImage;
    [[self navigationController] popViewControllerAnimated:YES];
    [self recognizeImageWithTesseract:_croppedImage];
    
    [self processingStateWithStatusMessage:@"Processing OCR"];
    [self clearCache:nil];
}

- (void)ImageCropViewControllerDidCancel:(ImageCropViewController *)controller{
    _imageView.image = nil;
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)error usingContextInfo:(void*)ctxInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!"
                                                        message:[NSString stringWithFormat:@"Saved with error %@", error.description]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Succes!"
                                                        message:@"Saved to camera roll"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}

- (void)processingStateWithStatusMessage:(NSString *)message {
    
    _statusLabel.text = message;
    _scanButton.hidden = YES;
    [_activityIndicator startAnimating];
}

- (void)finishedStateWithStatusMessage:(NSString *)message {
    _statusLabel.text = message;
    _scanButton.hidden = NO;
    [_activityIndicator stopAnimating];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)


- (void) showAlert {
    //If for the first time show button to save card format as well.
    //If user has saved card format do not prompt with that option.
    NSString *title = @"Confirm save!";
    NSString *message = @"Make sure all data are correct before you confirm.";
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Confirm", @"Confirm OK")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   [self.navigationController popViewControllerAnimated:YES];
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
