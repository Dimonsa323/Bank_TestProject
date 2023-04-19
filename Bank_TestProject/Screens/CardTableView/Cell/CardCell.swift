//
//  CardCell.swift
//  Bank_TestProject
//
//  Created by Дима Губеня on 19.04.2023.
//

import UIKit

enum CardCellAction {
    case unlock
}

class CardCell: UITableViewCell {

    // MARK: Layout

    private lazy var borderView: UIView = {
        let view = UIView()

        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.borderColor.color.cgColor
        view.layer.cornerRadius = 15

        return view
    }()

    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()

        return image
    }()

    private lazy var textVStack: UIStackView = {
        let vStack = UIStackView()
        vStack.spacing = 2
        vStack.axis = .vertical

        return vStack
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.bold.getFont(with: 16)
        label.textColor = Colors.mainLabel.color

        return label
    }()

    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.regular.getFont(with: 14)
        label.textColor = Colors.gray.color

        return label
    }()

    private lazy var cardImageView: UIImageView = {
        let image = UIImageView()
        image.setContentHuggingPriority(.required, for: .horizontal)
        image.setContentCompressionResistancePriority(.required, for: .horizontal)
        image.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(unlockCard))
        image.addGestureRecognizer(tapGesture)

        return image
    }()

    private lazy var lockButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Colors.mainLabel.color, for: .normal)
        button.titleLabel?.font = CustomFont.bold.getFont(with: 15)
        button.addTarget(self, action: #selector(unlockCard), for: .touchUpInside)

        return button
    }()

    private lazy var circleProgressView: CircleView = {
        let view = CircleView()

        return view
    }()

    // MARK: - Properties

    var actionClosure: ValueClosure<CardCellAction>?

    private var unlockTask: Task<Void, Error>?

    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        unlockTask?.cancel()
    }


    // MARK: - Methods

    @discardableResult
    func config(with model: Bank) -> CardCell {
        logoImageView.image = UIImage(named: model.status.mainImageName)!
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
        lockButton.setTitle(model.status.text, for: .normal)
        lockButton.layer.opacity = model.status.opacity
        lockButton.isEnabled = model.status.unlockIsEnable
        cardImageView.isUserInteractionEnabled = model.status.unlockIsEnable

        setCardImage(with: model.status.cardImageName)
        setNextStatusIfNeeded(with: model.status)

        return self
    }
}

// MARK: - Action

private extension CardCell {
    func setCardImage(with cardImageName: String) {
        if !cardImageName.isEmpty {
            circleProgressView.isHidden = true
            circleProgressView.layer.removeAnimation(forKey: "rotationAnimation")

            cardImageView.isHidden = false
            cardImageView.image = UIImage(named: cardImageName)
        } else {
            circleProgressView.isHidden = false
            cardImageView.isHidden = true
            circleProgressView.layer.add(createRotationAnimation(), forKey: "rotationAnimation")
        }
    }

    func setNextStatusIfNeeded(with status: Bank.CardStatus) {
        switch status {
        case .locked:
            print("Nothing")
        case .unlocked, .unlocking:
            unlockTask?.cancel()

            unlockTask = Task {
                do {
                    try await Task.sleep(seconds: 3)
                    actionClosure?(.unlock)
                } catch {
                    print(error)
                }
            }
        }
    }

    @objc
    func unlockCard() {
        actionClosure?(.unlock)
    }
}

// MARK: - Private Extension

private extension CardCell {
    func setupUI() {
        selectionStyle = .none
        cardImageView.isHidden = true
    }

    func createRotationAnimation() -> CABasicAnimation {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
        rotationAnimation.duration = 1.0
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = Float.infinity

        return rotationAnimation
    }

    func setupLayout() {
        textVStack.addArrangedSubview(titleLabel)
        textVStack.addArrangedSubview(subTitleLabel)
        
        contentView.addSubview(borderView)
        borderView.addSubview(logoImageView)
        borderView.addSubview(textVStack)
        borderView.addSubview(cardImageView)
        borderView.addSubview(lockButton)
        borderView.addSubview(circleProgressView)

        borderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }

        logoImageView.snp.makeConstraints {
            $0.height.width.equalTo(41)
            $0.leading.equalToSuperview().inset(28)
            $0.top.equalToSuperview().inset(18)
            $0.trailing.equalTo(textVStack.snp.leading).inset(-18)
        }

        textVStack.snp.makeConstraints {
            $0.centerY.equalTo(logoImageView.snp.centerY)
            $0.trailing.equalTo(cardImageView.snp.leading).inset(-16)
        }

        cardImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.top.equalToSuperview().inset(18)

        }

        circleProgressView.snp.makeConstraints {
            $0.centerY.equalTo(logoImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(27)
            $0.height.width.equalTo(43)
        }

        lockButton.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).inset(-14)
            $0.height.equalTo(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}
