//
//  PageViewController.swift
//  Armut
//
//  Created by Semafor Teknolojı on 3.09.2020.
//  Copyright © 2020 Semafor Teknolojı. All rights reserved.
//


import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource{

    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(viewController: "sbSignUp"),
                self.newViewController(viewController: "sbMaster"),
                self.newViewController(viewController: "sbLogin")]
    }()
    
    var pageControl =  UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.dataSource = self
        if orderedViewControllers.first != nil{
                   setViewControllers([orderedViewControllers[1]],
                                      direction: .forward,
                                      animated: true,
                                      completion: nil)
               }
               // Do any additional setup after loading the view.
             
               self.delegate = self
               configurePageControl()
    }
    
       func configurePageControl(){
           pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
           pageControl.numberOfPages = orderedViewControllers.count
           pageControl.currentPage = 0
           pageControl.tintColor = UIColor.black
           pageControl.pageIndicatorTintColor = UIColor.white
           pageControl.currentPageIndicatorTintColor = UIColor.black
           self.view.addSubview(pageControl)
       }
       
       func newViewController (viewController: String) -> UIViewController{
           return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
       }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex else {
            return nil //loop olmasin
        }
        
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
       func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
           let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController)!
       }
       
       func nextPageWithIndex(index: Int) {
            setViewControllers([orderedViewControllers[index]], direction: .forward, animated: true, completion: nil)
            //orderedViewControllers[index]
       }
       
}
