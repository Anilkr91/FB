//
//  WalkthroughViewController.swift
//  StayAPT
//
//  Created by admin on 07/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class WalkthroughViewController: BaseViewController, UIPageViewControllerDataSource {
    
    // MARK: - Variables
    fileprivate var pageViewController: UIPageViewController?
    fileprivate var contentImages: [WalkthroughModel] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentImages = [ WalkthroughModel(name: "loader", heading: "Heading1", text: "The best place to invest is in FITNESS"),
                          WalkthroughModel(name: "placeholder-profile", heading: "Heading1", text: "Stay focus & accomplish your desired goals"),
                          WalkthroughModel(name: "loader", heading: "Heading1", text: "Challenging yourself everyday is one of the most exciting ways to live."),
                          WalkthroughModel(name: "placeholder-profile", heading: "Heading1", text: "It's easy to stay focused when you are with your friends or surrounded by people with same fitness level.")
        ]
        
        createPageViewController()
        setupPageControl()
        
//        showGetStartedSegue
    }
    
    fileprivate func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        pageController.dataSource = self
        
        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParentViewController: self)
    }
    
    
    func resetController() {
        
        
    }
    
    fileprivate func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.blue
        appearance.backgroundColor = UIColor.clear
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        if itemController.pageIndex > 0 {
            return getItemController(itemController.pageIndex-1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        let index = itemController.pageIndex
        if (index == contentImages.count - 1) || (index == NSNotFound) {
            return getItemController(0)!
            
        } else {
            return getItemController(itemController.pageIndex+1)
        }
    }
    
    fileprivate func getItemController(_ itemIndex: Int) -> PageItemController? {
        
        if itemIndex < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewController(withIdentifier: "PageItemController") as! PageItemController
            pageItemController.pageIndex = itemIndex
            pageItemController.imageName = contentImages[itemIndex].name
            pageItemController.heading = contentImages[itemIndex].heading
            pageItemController.desc = contentImages[itemIndex].text
            return pageItemController
        
        }
        return nil
    }
    
    // MARK: - Page Indicator
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    // MARK: - Additions
    
    func currentControllerIndex() -> Int {
        
        let pageItemController = self.currentController()
        
        if let controller = pageItemController as? PageItemController {
            return controller.pageIndex
        }
        return -1
    }
    
    func currentController() -> UIViewController? {
        
        if (self.pageViewController?.viewControllers?.count)! > 0 {
            return self.pageViewController?.viewControllers![0]
        }
        return nil
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showGetStartedSegue", sender: self)
    }
}
