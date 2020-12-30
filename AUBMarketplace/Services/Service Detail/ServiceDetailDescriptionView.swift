//
//  ServiceDetailDescriptionView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/26/20.
//

import UIKit

class ServiceDetailDescriptionView: UIView {

    let service: Service
    
    let titleLabel = UILabel()
    let datePosted = UILabel()
    let descriptionLabel = UILabel()
    
    init(service: Service) {
        self.service = service
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ServiceDetailDescriptionView {
    private func setupSubviews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Description"
        titleLabel.setDynamicFont(forTextStyle: .title2)
//        titleLabel.backgroundColor = .systemGreen
        
        datePosted.translatesAutoresizingMaskIntoConstraints = false
        datePosted.text = "5d ago"
        datePosted.textColor = .secondaryLabel
        datePosted.setDynamicFont(forTextStyle: .callout)
        datePosted.textAlignment = .right
//        datePosted.backgroundColor = .systemBlue
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = """
            He walked down the steps from the train station in a bit of a hurry knowing the secrets in the briefcase must be secured as quickly as possible. Bounding down the steps, he heard something behind him and quickly turned in a panic. There was nobody there but a pair of old worn-out shoes were placed neatly on the steps he had just come down. Had he past them without seeing them? It didn't seem possible. He was about to turn and be on his way when a deep chill filled his body.
            Waiting and watching. It was all she had done for the past weeks. When you’re locked in a room with nothing but food and drink, that’s about all you can do anyway. She watched as birds flew past the window bolted shut. She couldn’t reach it if she wanted too, with that hole in the floor. She thought she could escape through it but three stories is a bit far down.
            The box sat on the desk next to the computer. It had arrived earlier in the day and business had interrupted her opening it earlier. She didn't who had sent it and briefly wondered who it might have been. As she began to unwrap it, she had no idea that opening it would completely change her life.
            Since they are still preserved in the rocks for us to see, they must have been formed quite recently, that is, geologically speaking. What can explain these striations and their common orientation? Did you ever hear about the Great Ice Age or the Pleistocene Epoch? Less than one million years ago, in fact, some 12,000 years ago, an ice sheet many thousands of feet thick rode over Burke Mountain in a southeastward direction. The many boulders frozen to the underside of the ice sheet tended to scratch the rocks over which they rode. The scratches or striations seen in the park rocks were caused by these attached boulders. The ice sheet also plucked and rounded Burke Mountain into the shape it possesses today.
            """
        descriptionLabel.textAlignment = .natural
        descriptionLabel.numberOfLines = 0
        descriptionLabel.setDynamicFont(forTextStyle: .body)
//        descriptionLabel.backgroundColor = .systemTeal
    }
}

extension ServiceDetailDescriptionView {
    private func setupConstraints() {
        addSubview(titleLabel)
        addSubview(datePosted)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            
            datePosted.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            datePosted.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: datePosted.leadingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
