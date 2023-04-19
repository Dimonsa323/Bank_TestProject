//
//  CardsViewController .swift
//  Bank_TestProject
//
//  Created by Дима Губеня on 17.04.2023.
//

import UIKit
import SnapKit

// MARK: - CardsViewController

class CardsViewController: BaseViewController {
    
    // MARK: Layout
    
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    
    private lazy var welcomeLabel: UILabel = {
        let welcomeLabel: UILabel = UILabel()
        welcomeLabel.text = "Welcome"
        welcomeLabel.font = CustomFont.bold.getFont(with: 35)
        
        return welcomeLabel
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel: UILabel = UILabel()
        nameLabel.text = "Bank"
        nameLabel.font = CustomFont.bold.getFont(with: 25)
        
        return nameLabel
    }()
    
    private lazy var creditCardLabel: UILabel = {
        let creditCard: UILabel = UILabel()
        creditCard.text = "Credit card"
        creditCard.font = CustomFont.bold.getFont(with: 20)
        
        return creditCard
    }()
    
    private lazy var logoImageView: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = Constants.logoBankImage
        
        return logoImage
    }()
    
    private lazy var settingButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.configuration = .plain()
        button.setImage(Constants.iconSettings, for: .normal)
        button.addTarget(self, action: #selector(didTapToSettings), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    
    private let navigator: NavigatorProtocol
    
    private let cardsData: CardsTableViewDataSourceProtocol = BankData()
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        getMockData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

private extension CardsViewController {
    @objc
    func didTapToSettings() {
        
    }
}

// MARK: - Private MapKit Extension

private extension CardsViewController {
    func getMockData() {
        tableView.showActivityIndicator()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.tableView.layer.opacity = 0
            self?.cardsData.getMockDate()
            self?.tableView.reloadData()
            self?.tableView.hideActivityIndicatorView()

            UIView.animate(withDuration: 1) {
                self?.tableView.layer.opacity = 1
            }
        }
    }
    func setupUI() {
        view.backgroundColor = .white

        tableView.registerCellProgramically(type: CardCell.self)
        tableView.showsVerticalScrollIndicator = false
    }

    func setupLayout() {
        view.addSubview(nameLabel)
        view.addSubview(settingButton)
        view.addSubview(logoImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(creditCardLabel)
        view.addSubview(tableView)

        nameLabel.snp.makeConstraints {
            $0.height.equalTo(17)
            $0.width.equalTo(86)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            $0.centerY.equalTo(settingButton.snp.centerY)
        }

        settingButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(27)
            $0.height.width.equalTo(45)
        }

        logoImageView.snp.makeConstraints {
            $0.top.equalTo(settingButton.snp.bottom)
            $0.trailing.equalToSuperview()
        }

        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-63)
            $0.leading.equalToSuperview().inset(24)
        }

        creditCardLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).inset(-31)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(creditCardLabel.snp.bottom).inset(-26)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}

// MARK: - TableViewDataSource & TableViewDelegate

extension CardsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cardsData.countCards
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(withType: CardCell.self, for: indexPath) as! CardCell
        var card = cardsData.getCard(with: indexPath.row)
        
        cell.config(with: card)
        cell.actionClosure = {  [weak self] action in
            self?.handleAction(with: action, card: &card, tableView: tableView, indexPath: indexPath)
        }

        return  cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    private func handleAction(
        with type: CardCellAction,
        card: inout Bank,
        tableView: UITableView,
        indexPath: IndexPath
    ) {
        switch type {
        case .unlock:
            tableView.performBatchUpdates {
                card.changeCardStatus()
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
}
