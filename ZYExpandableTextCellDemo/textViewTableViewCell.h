//
//  textViewTableViewCell.h
//  ZYExpandableTextCellDemo
//
//  Created by 中商国际 on 2018/2/6.
//  Copyright © 2018年 中商国际. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZY_TextView.h"

@protocol ExpandableTableViewDelegate <UITableViewDelegate>

@required
- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath;

@end
@interface textViewTableViewCell : UITableViewCell

@property (nonatomic, weak) UITableView *expandableTableView;
@property (nonatomic, strong, readonly) ZY_TextView *textView;

@property (nonatomic, readonly) CGFloat cellHeight;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UILabel * leftLabel;
//@property (nonatomic, assign) id<ExpandableTableViewDelegate>delegate;
@end

#pragma mark -

@interface UITableView (textViewTableViewCell)

// return the cell with the specified ID. It takes care of the dequeue if necessary
- (textViewTableViewCell *)expandableTextCellWithId:(NSString *)cellId;

@end
