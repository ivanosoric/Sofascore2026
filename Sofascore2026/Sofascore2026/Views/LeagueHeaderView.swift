
import UIKit
import SnapKit

final class LeagueHeaderView: UIView {
    private let logoImageView = UIImageView()
    private let countryLabel = UILabel()
    private let chevronLabel = UILabel()
    private let leagueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: LeagueHeaderViewModel) {
        countryLabel.text = viewModel.countryName
        leagueLabel.text = viewModel.leagueName

        logoImageView.image = UIImage(named: viewModel.logoImageName)
    }
    
    private func setupView() {
        addSubview(logoImageView)
        addSubview(countryLabel)
        addSubview(chevronLabel)
        addSubview(leagueLabel)
    }
    
    private func setupStyle() {
        backgroundColor = .clear

        logoImageView.contentMode = .scaleAspectFit
        logoImageView.tintColor = .systemBlue

        countryLabel.font = AppFonts.leagueTitle
        countryLabel.textColor = AppColors.primaryText
        countryLabel.numberOfLines = 1

        chevronLabel.text = "›"
        chevronLabel.font = AppFonts.leagueSubtitle
        chevronLabel.textColor = AppColors.secondaryText

        leagueLabel.font = AppFonts.leagueSubtitle
        leagueLabel.textColor = AppColors.secondaryText
        leagueLabel.numberOfLines = 1
    }
    
    private func setupLayout() {
        logoImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.size.equalTo(32)
        }

        countryLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(logoImageView)
        }

        chevronLabel.snp.makeConstraints {
            $0.leading.equalTo(countryLabel.snp.trailing).offset(6)
            $0.centerY.equalTo(countryLabel)
        }

        leagueLabel.snp.makeConstraints {
            $0.leading.equalTo(chevronLabel.snp.trailing).offset(6)
            $0.centerY.equalTo(chevronLabel)
            $0.trailing.lessThanOrEqualToSuperview()
        }
    }
    
}
