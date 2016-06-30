//
//  ZWTextKitController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWTextKitTableViewController.h"
#import "ZWBaseTableViewCell.h"
#import "ZWNote.h"
#import "ZWNoteEditorViewController.h"

static NSString *CELL_IDENTIFIER = @"cell_identifier";

@implementation ZWTextKitTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Text Kit学习样例";
    
    [self inilializeDataArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)inilializeDataArray
{
    self.dataArray = @[
                       [ZWNote noteWithText:@"Shopping List\r\r1. Cheese\r2. Biscuits\r3. Sausages\r4. IMPORTANT Cash for going out!\r5. -potatoes-\r6. A copy of iOS6 by tutorials\r7. A new iPhone\r8. A present for mum"],
                       [ZWNote noteWithText:@"Meeting notes\rA long and drawn out meeting, it lasted hours and hours and hours!"],
                       [ZWNote noteWithText:@"Perfection ... \n\nPerfection is achieved not when there is nothing left to add, but when there is nothing left to take away - Antoine de Saint-Exupery"],
                       [ZWNote noteWithText:@"Notes on iOS7\nThis is a big change in the UI design, it's going to take a *lot* of getting used to!"],
                       [ZWNote noteWithText:@"Meeting notes\rA dfferent meeting, just as long and boring"],
                       [ZWNote noteWithText:@"A collection of thoughts\rWhy do birds sing? Why is the sky blue? Why is it so hard to create good test data?"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];

    [cell.textLabel setText:((ZWNote *)self.dataArray[indexPath.row]).title];
    cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWNoteEditorViewController *editorController = [ZWNoteEditorViewController new];
    editorController.note = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:editorController animated:YES];
}

@end
