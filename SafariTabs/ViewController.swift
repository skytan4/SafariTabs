//
//  ViewController.swift
//  SafariTabs
//
//  Created by Skyler Tanner on 1/26/16.
//  Copyright © 2016 The Church of Jesus Christ of Latter-day Saints. All rights reserved.
//

import UIKit
import TRTabView

class ViewController: UIViewController, TRTabViewDelegate {


    @IBOutlet weak var contentView: ContentView!
    @IBOutlet weak var tabView: TRTabView!
    var pages:[ContentViewController] = []
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.tintColor = UIColor.lightGrayColor()
        tabView.delegate = self
        tabView.deleteButtonMode = TRTabViewButtonMode.Selected
        tabView.showAddButton = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfTabsInTabView(tabView: TRTabView!) -> UInt {
        return UInt(self.pages.count)
    }

    func tabView(tabView: TRTabView!, tabForIndex index: UInt) -> TRTab! {
        let tab = tabView.dequeueDefaultTabForIndex(index)
        tab.titleLabel.text = "Tab \(self.pages[Int(index)].title!)"
        
        return tab
    }

    func overflowTitleForIndex(index: UInt) -> String! {
        return "Overflow"
    }
    
    func tabView(tabView: TRTabView!, didSelectTabAtIndex index: UInt) {
        let view = self.pages[Int(index)]
//        if self.childViewControllers.first?.childViewControllers.first == nil {
//            hideContentController(self.childViewControllers.first?.childViewControllers.first as! ContentViewController)
//        }
        displayContentController(view)
        
        /* Display content view for model object */
    }
   
    func displayContentController (contentViewController: ContentViewController) {
        
        self.addChildViewController(contentViewController)
        contentViewController.view.frame = self.contentView.frame
        self.view.addSubview(contentViewController.view)
        contentViewController.didMoveToParentViewController(self)
    }

    func hideContentController (content: ContentViewController) {
        content.willMoveToParentViewController(nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    func tabViewCommitTabAddition(tabView: TRTabView!) {
        let viewController = ContentViewController()
        count++
        
        if count % 2 == 0 {
            viewController.view.backgroundColor = UIColor.redColor()
        } else {
            viewController.view.backgroundColor = UIColor.blueColor()
        }
        viewController.title = "\(count)"
        self.pages.append(viewController)
        
        tabView.addTabAtIndex(tabView.numberOfTabs, animated: true)
        
    }
    
    func tabView(tabView: TRTabView!, commitTabDeletionAtIndex index: UInt) {
        hideContentController(self.pages[Int(index)])
        self.pages.removeAtIndex(Int(index))
        self.tabView.deleteTabAtIndex(index, animated: true)
    }

//   //    If you enable tab deletion (tabView.deleteButtonMode != TRTabViewButtonModeNever), you need to handle tab deletion:
    

    
}

