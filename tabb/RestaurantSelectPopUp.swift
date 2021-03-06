//
//  RestaurantSelectPopUp.swift
//  tabb
//
//  Created by LeeDongMin on 4/14/16.
//  Copyright © 2016 LeeDongMin. All rights reserved.
//

import UIKit

class RestaurantSelectPopUp: UIViewController {

    var message = UILabel()
    var popUp = UIView()
    
    var detailScroll: UIScrollView!

    var arrayForBool : NSMutableArray = NSMutableArray()
    
    var selectBoxs = Array<UIButton>()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColorFromHex(0x111111, alpha: 0.8)
        
    }
    
    func showInView(aView: UIView!, withMessage message: String!, animated: Bool, items : NSMutableArray) {
        let window = UIApplication.sharedApplication().keyWindow!
        let menuWrapperBounds = window.bounds
        
        self.popUp = UIView()
        let screen: CGRect = UIScreen.mainScreen().bounds
        self.popUp.layer.shadowOpacity = 0.8
        self.popUp.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        self.popUp.backgroundColor = UIColor.clearColor()
        self.popUp.frame = CGRectMake(0, 0,  menuWrapperBounds.width, menuWrapperBounds.height)
        
        detailScroll = UIScrollView()
        detailScroll.backgroundColor = UIColor.clearColor()
        detailScroll.frame = CGRectMake(0, (screen.size.height * 150) / 736, screen.size.width, (screen.size.height * 478) / 736)
        self.popUp.addSubview(detailScroll)
        
        let topImage = UIImageView(image: UIImage(named: "pop_top"))
        topImage.frame = CGRectMake((screen.size.width * 47) / 414, 0, (screen.size.width * 320) / 414, (screen.size.height * 124) / 736)
        detailScroll.addSubview(topImage)
        
        let contentView = UIView()
        contentView.frame = CGRectMake((screen.size.width * 47) / 414, (screen.size.height * 274) / 736, (screen.size.width * 320) / 414, (screen.size.height * 400) / 736)
        contentView.backgroundColor = UIColor.whiteColor()
        detailScroll.addSubview(contentView)
        
        let subScript = UILabel(frame: CGRect(x: (screen.size.width * 15) / 414, y: (screen.size.height * 17) / 736, width: (screen.size.width * 368) / 414, height: (screen.size.height * 20) / 736))
        subScript.numberOfLines = 0
        subScript.text = "Select Restaurant."
        subScript.textColor = UIColorFromHex(0x999999, alpha: 1.0)
        subScript.font = UIFont(name: latoBold, size: (screen.size.width * 12) / 414)
        contentView.addSubview(subScript)
        
        let scriptLine = UIView()
        scriptLine.frame = CGRectMake(0, (screen.size.height * 56) / 736, (screen.size.width * 320) / 414, 1)
        scriptLine.backgroundColor = UIColorFromHex(0xcccccc, alpha: 1.0)
        contentView.addSubview(scriptLine)
        
        let optionTitleView = UIView()
        optionTitleView.frame = CGRectMake(0, scriptLine.frame.origin.y + scriptLine.frame.size.height, (screen.size.width * 320) / 414, (screen.size.height * 30) / 736)
        optionTitleView.backgroundColor = UIColorFromHex(0xf2f2f2, alpha: 1.0)
        contentView.addSubview(optionTitleView)
        
        let optionTitle = UILabel()
        optionTitle.frame = CGRectMake((screen.size.width * 15) / 414, (screen.size.height * 5) / 736, (screen.size.width * 320) / 414, (screen.size.height * 20) / 736)
        optionTitle.text = "Restaurant Name"
        optionTitle.textColor = UIColorFromHex(0xc13939, alpha: 1.0)
        optionTitle.font = UIFont(name: latoBold, size: (screen.size.width * 11) / 414)
        optionTitleView.addSubview(optionTitle)
        
        let optionLine = UIView()
        optionLine.frame = CGRectMake(0, optionTitleView.frame.origin.y + optionTitleView.frame.size.height, (screen.size.width * 320) / 414, 1)
        optionLine.backgroundColor = UIColorFromHex(0xcccccc, alpha: 1.0)
        contentView.addSubview(optionLine)
        
        let subOrignY = optionLine.frame.origin.y + optionLine.frame.size.height
        let subMenuHeight : CGFloat = (screen.size.height * 46) / 736
        var heightCount : CGFloat = 0
        
        if(checkInRestaurantList.count > 0) {
            for(var index=0; index<checkInRestaurantList.count; index++) {
                arrayForBool.addObject(false)
                let subMenu = UILabel()
                subMenu.frame = CGRectMake((screen.size.width * 15) / 414, subOrignY + (subMenuHeight * heightCount), (screen.size.width * 200) / 414, subMenuHeight)
                subMenu.text = checkInRestaurantList[index].objectForKey("name") as? String
                subMenu.textColor = UIColorFromHex(0x666666, alpha: 1.0)
                subMenu.font = UIFont(name: lato, size: (screen.size.width * 11) / 414)
                contentView.addSubview(subMenu)
                
                let selectBox = UIButton()
                selectBox.frame = CGRectMake((screen.size.width * 278) / 414, subOrignY + (subMenuHeight * heightCount) + (screen.size.height * 9.5) / 736, (screen.size.width * 27) / 414, (screen.size.height * 27) / 736)
                selectBox.setImage(UIImage(named: "btn_check_off2"), forState: .Normal)
                selectBox.setImage(UIImage(named: "btn_check_on2"), forState: .Selected)
                selectBox.tag = index
                selectBox.addTarget(self, action: "changeSelect:", forControlEvents: .TouchUpInside)
                contentView.addSubview(selectBox)
                
                selectBoxs.append(selectBox)

                
                let line = UIView()
                line.frame = CGRectMake(0, subOrignY + (subMenuHeight * (heightCount+1)), (screen.size.width * 320) / 414, 1)
                line.backgroundColor = UIColorFromHex(0xcccccc, alpha: 1.0)
                contentView.addSubview(line)
                
                heightCount++
            }
            
        }
        
        let close: UIButton = UIButton()
        let trySearch : UIButton = UIButton()
        
        close.frame = CGRectMake((screen.size.width * 207) / 414, (screen.size.height * 674) / 736, (screen.size.width * 160) / 414, (screen.size.height * 54) / 736)
        close.setTitle("OK", forState: UIControlState.Normal)
        close.setTitleColor(UIColorFromRGB(0xffffff), forState: UIControlState.Normal)
        close.setBackgroundImage(UIImage.imageWithColor(UIColor.colorWithHex("#c13939")), forState: .Normal)
        close.setBackgroundImage(UIImage.imageWithColor(UIColor.colorWithHex("#c13939", alpha: 0.5)), forState: .Highlighted)
        close.roundCorners(([.BottomRight]), radius: (screen.size.width * 3.5) / 414)
        close.clipsToBounds = true
        close.addTarget(self, action: "close:", forControlEvents: UIControlEvents.TouchUpInside)
        detailScroll.addSubview(close)
        
        trySearch.frame = CGRectMake((screen.size.width * 47) / 414, (screen.size.height * 674) / 736, (screen.size.width * 160) / 414, (screen.size.height * 54) / 736)
        trySearch.setTitle("Search Again", forState: UIControlState.Normal)
        trySearch.setTitleColor(UIColorFromRGB(0xffffff), forState: UIControlState.Normal)
        trySearch.setBackgroundImage(UIImage.imageWithColor(UIColor.colorWithHex("#c13939")), forState: .Normal)
        trySearch.setBackgroundImage(UIImage.imageWithColor(UIColor.colorWithHex("#c13939", alpha: 0.5)), forState: .Highlighted)
        trySearch.roundCorners(([.BottomLeft]), radius: (screen.size.width * 3.5) / 414)
        trySearch.clipsToBounds = true
        trySearch.addTarget(self, action: "searchAgain:", forControlEvents: UIControlEvents.TouchUpInside)
        detailScroll.addSubview(trySearch)
        
        let line = UIView()
        line.frame = CGRectMake((screen.size.width * 206) / 414, (screen.size.height * 677) / 736, 1, (screen.size.height * 48) / 736)
        line.backgroundColor = UIColorFromHex(0xd37575, alpha: 1.0)
        detailScroll.addSubview(line)
        
        self.view.addSubview(self.popUp)
        
        window.addSubview(self.view)
        
        //위치 재조정
        contentView.frame = CGRectMake((screen.size.width * 47) / 414, (screen.size.height * 124) / 736, (screen.size.width * 320) / 414, subOrignY + (subMenuHeight * heightCount))
        
        let button_y = (contentView.frame.height + contentView.frame.origin.y)
        
        close.frame = CGRectMake((screen.size.width * 207) / 414, button_y, (screen.size.width * 160) / 414, (screen.size.height * 54) / 736)
        trySearch.frame = CGRectMake((screen.size.width * 47) / 414, button_y, (screen.size.width * 160) / 414, (screen.size.height * 54) / 736)
        line.frame = CGRectMake((screen.size.width * 206) / 414, button_y + (screen.size.height * 3) / 736, 1, (screen.size.height * 48) / 736)
        
        let popUpHeight = button_y + (screen.size.height * 54) / 736
        
        if(popUpHeight > screen.size.height) {
            detailScroll.frame = CGRectMake(0, 0, screen.size.width, screen.size.height)
            detailScroll.contentSize = CGSize(width: contentView.frame.width, height: popUpHeight)
        } else {
            detailScroll.frame = CGRectMake(0, (screen.size.height - popUpHeight) / 2, screen.size.width, popUpHeight)
            detailScroll.contentSize = CGSize(width: contentView.frame.width, height: popUpHeight)
        }
        
        if animated
        {
            self.showAnimate()
        }
    }
    
    
    func showAnimate()
    {
        
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.15, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animateWithDuration(0.15, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    func close(sender: AnyObject?) {
        
        for(var index = 0; index < checkInRestaurantList.count; ++index) {
            if(arrayForBool.objectAtIndex(index).boolValue == true) {
                print("restaurant name : \(checkInRestaurantList[index].objectForKey("name") as! String), id : \(checkInRestaurantList[index].objectForKey("restaurantId") as! Double))")
                
                restaurantId = checkInRestaurantList[index].objectForKey("restaurantId") as! Double
                browse.getRestaurantView(restaurantId)
            }
            
        }
        
        self.removeAnimate()
    }
    
    func searchAgain(sender: AnyObject?) {
        if(browse != nil) {
            browse.searchRestaurant()
        }
        
        self.removeAnimate()
    }
    
    func changeSelect(sender : UIButton) {
        for(var index = 0; index < selectBoxs.count; ++index) {
            if(index == sender.tag) {
                selectBoxs[index].selected = true
                arrayForBool.replaceObjectAtIndex(index, withObject: true)
            } else {
                selectBoxs[index].selected = false
                arrayForBool.replaceObjectAtIndex(index, withObject: false)
            }
        }
        
    }

}
