//
//  OnboardingViewController.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController    {
    
    private let localizationManager = LocalizationManager.localizationManager
    
    let stackView = UIStackView ()
    let button = UIButton (type: .system)
    let allNewsLabel = UILabel()
    let firstToKnowLabel = UILabel ()
    let pageControl = UIPageControl()
    let scrollView = UIScrollView()
    let imagesOfCity = ["mainScreen", "catigory"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollViewConfigure()
        pageControlFunc()
        labelConfigure ()
        buttonConfigure()
        stackViewConfigure()
        constrainrs()
        button.addTarget(self, action: #selector(didTapButton(_ :)), for: .touchUpInside)
    }
    
    //Scroll View
    func scrollViewConfigure () {
        stackView.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.frame.size.width*2, height: scrollView.frame.size.width)
        
        //        scrollView.isPagingEnabled = true
        
        for x in 0..<2 {
            let xPos = CGFloat(x)*self.view.frame.size.width + 60
            let page = UIImageView(frame: CGRect(x: xPos / 1.2, y: 20, width: 286, height: 336))
            
            scrollView.contentSize = CGSize(width: 720, height: scrollView.frame.size.height)
            
            page.image = UIImage(named: imagesOfCity[x])
            
            pageControl.currentPage += 1
            page.layer.cornerRadius = 20
            scrollView.addSubview(page)
        }
    }
    
    @objc func didTapButton (_ button: UIButton) {
        guard button.tag < 1 else {
            dismiss(animated: true, completion: nil)
            return
        }
        pageControl.currentPage += 1
        //        firstToKnowLabel.text = "Все новости в одном месте"
        scrollView.setContentOffset(CGPoint(x:  view.frame.size.width - 70, y: 0), animated: true)
        button.setTitle(localizationManager.localizeString("ONBOARDING_GET_STARTED_BUTTON"), for: .normal)
        
        if button.titleLabel?.text == "Get Started" || button.titleLabel?.text == "Начать" {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            let authVC = AuthorizationViewController()
            authVC.modalPresentationStyle = .fullScreen
            self.present(authVC, animated: true)
        }
    }
    
    //StackView
    func stackViewConfigure () {
        view.addSubview(stackView)
        stackView.backgroundColor = .white
        stackView.addSubview(button)
    }
    
    //Button
    func buttonConfigure () {
        button.configure(title: localizationManager.localizeString("ONBOARDING_NEXT_BUTTON"))
    }
    
    // Labels
    func labelConfigure () {
        stackView.addSubview(allNewsLabel)
        stackView.addSubview(firstToKnowLabel)
        allNewsLabel.numberOfLines = 2
        allNewsLabel.textColor = .gray
        allNewsLabel.textAlignment = .center
        allNewsLabel.text = localizationManager.localizeString("ONBOARDING_FIRST_COMMENT_LABEL")
        firstToKnowLabel.text = localizationManager.localizeString("ONBOARDING_FIRST_LABEL")
        firstToKnowLabel.textAlignment = .center
        firstToKnowLabel.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    //PageControl
    func pageControlFunc () {
        stackView.addSubview(pageControl)
        pageControl.isEnabled = false
        pageControl.numberOfPages = imagesOfCity.count
        pageControl.tintColor = UIColor(named: "purpleColor")
        
        pageControl.pageIndicatorTintColor = UIColor(named: "grayLighter")
        pageControl.currentPageIndicatorTintColor = UIColor(named: "purpleColor")
    }
        
    //Constraints
    func constrainrs () {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        allNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        firstToKnowLabel.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            button.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -14),
            button.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 14),
            button.bottomAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            allNewsLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            allNewsLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            allNewsLabel.bottomAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.bottomAnchor, constant: -170),
            
            firstToKnowLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            firstToKnowLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            firstToKnowLabel.bottomAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.bottomAnchor, constant: -242),
            
            pageControl.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            pageControl.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            pageControl.bottomAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.bottomAnchor, constant: -356),
            //
            scrollView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 50),
            scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -30),
            
            //            pager.trailingAnchor.constraint(equalTo: viewOfImages.trailingAnchor, constant: 0),
            //            pager.leadingAnchor.constraint(equalTo: viewOfImages.leadingAnchor, constant: 0),
            //            pager.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension OnboardingViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x)) - Float (70))
        firstToKnowLabel.text = localizationManager.localizeString("ONBOARDING_SECOND_LABEL")
        allNewsLabel.text = localizationManager.localizeString("ONBOARDING_SECOND_COMMENT_LABEL")
        if pageControl.currentPage == 0 {
            firstToKnowLabel.text = "Главный экран"
            allNewsLabel.text = localizationManager.localizeString("ONBOARDING_FIRST_COMMENT_LABEL")
        }
    }
}
