//
//  OnboardingViewController.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import Foundation
import UIKit
import HSCycleGalleryView



class OneboardingVC: UIViewController, HSCycleGalleryViewDelegate   {
    func numberOfItemInCycleGalleryView(_ cycleGalleryView: HSCycleGalleryView) -> Int {
        return 3
    }
    
    func cycleGalleryView(_ cycleGalleryView: HSCycleGalleryView, cellForItemAtIndex index: Int) -> UICollectionViewCell {
        let cell = cycleGalleryView.dequeueReusableCell(withIdentifier: "cell", for: IndexPath(item: index, section: 0))
        let image = UIImage(named: "cityOne")
        cell.addSubview(cityImages)
        cell.backgroundColor = .blue
        return cell
    }
    
    
    let pager = HSCycleGalleryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))

    let stackView = UIStackView ()
    let button = UIButton (type: .system)
    let allNewsLabel = UILabel()
    let firstToNowLabel = UILabel ()
    let pageControl = UIPageControl()
    
    let viewOfImages = UIView()
    let cityImages = UIImageView()
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityImages.image = UIImage(named: "cityOne")
        cityImages.contentMode = .scaleAspectFit
        collectionViewConfigure()
        pageControlFunc()
        labelConfigure ()
        buttonConfigure()
        stackViewConfigure()
        constrainrs()
       
      
      
    }
    
    
    //StackView
    
    func stackViewConfigure () {
        view.addSubview(stackView)
        stackView.backgroundColor = .white
    }
    
    //CollectionView
    
    func collectionViewConfigure () {
        stackView.addSubview(viewOfImages)
        viewOfImages.addSubview(pager)
     
        pager.register(cellClass: CollectionViewCell.self, forCellReuseIdentifier: "cell")
        pager.delegate = self
        pager.reloadData()
    }
    //Button
    
    func buttonConfigure () {
        stackView.addSubview(button)
        button.configure(title: "Next")
    }
    
    // Labels
    
    func labelConfigure () {
        stackView.addSubview(allNewsLabel)
        stackView.addSubview(firstToNowLabel)
        allNewsLabel.numberOfLines = 2
        allNewsLabel.textColor = .gray
        allNewsLabel.textAlignment = .center
        allNewsLabel.setLineSpacing(lineSpacing: 24)
        allNewsLabel.text = "All news in one place, be \nthe first to know last news"
        firstToNowLabel.text = "First to now"
        firstToNowLabel.textAlignment = .center
        firstToNowLabel.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    //PageControl
    
    func pageControlFunc () {
        stackView.addSubview(pageControl)
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor(named: "grayLighter")
        pageControl.currentPageIndicatorTintColor = UIColor(named: "purpleColor")
    }
    
    
    //Constraints
    
    func constrainrs () {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        allNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        firstToNowLabel.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pager.translatesAutoresizingMaskIntoConstraints = false
        viewOfImages.translatesAutoresizingMaskIntoConstraints = false
        cityImages.translatesAutoresizingMaskIntoConstraints = false
        
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

            firstToNowLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            firstToNowLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            firstToNowLabel.bottomAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.bottomAnchor, constant: -242),
            
            pageControl.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -60),
            pageControl.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 60),
            pageControl.bottomAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.bottomAnchor, constant: -356),
//
            viewOfImages.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0),
            viewOfImages.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            viewOfImages.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0),
            viewOfImages.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -30),

            pager.trailingAnchor.constraint(equalTo: viewOfImages.trailingAnchor, constant: 0),
            pager.leadingAnchor.constraint(equalTo: viewOfImages.leadingAnchor, constant: 0),
            pager.topAnchor.constraint(equalTo: viewOfImages.topAnchor, constant: 120)
            
            
            
        ])
    }
}
