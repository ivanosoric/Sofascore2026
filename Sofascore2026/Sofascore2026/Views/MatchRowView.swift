import UIKit
import SnapKit
import SofaAcademic

final class MatchRowView: BaseView {
    
    private let timeLabel = UILabel()
    private let statusLabel = UILabel()
    
    private let separatorView = UIView()
    
    private let homeLogoImageView = UIImageView()
    private let awayLogoImageView = UIImageView()
    
    private let homeTeamLabel = UILabel()
    private let awayTeamLabel = UILabel()
    
    private let homeScoreLabel = UILabel()
    private let awayScoreLabel = UILabel()
    
    func configure(with viewModel: MatchRowViewModel) {
        timeLabel.text = viewModel.timeText
        statusLabel.text = viewModel.statusText
        statusLabel.textColor = viewModel.statusColor
        
        homeTeamLabel.text = viewModel.homeTeamName
        awayTeamLabel.text = viewModel.awayTeamName
        
        homeScoreLabel.text = viewModel.homeTeamScore
        awayScoreLabel.text = viewModel.awayTeamScore
        
        homeScoreLabel.textColor = viewModel.scoreColor
        awayScoreLabel.textColor = viewModel.scoreColor
        
        homeLogoImageView.setImage(from: viewModel.homeLogoURL)
        awayLogoImageView.setImage(from: viewModel.awayLogoURL)
    }
    
    override func addViews() {
        addSubview(timeLabel)
        addSubview(statusLabel)
        addSubview(separatorView)
        addSubview(homeLogoImageView)
        addSubview(awayLogoImageView)
        addSubview(homeTeamLabel)
        addSubview(awayTeamLabel)
        addSubview(homeScoreLabel)
        addSubview(awayScoreLabel)
    }
    
    override func styleViews() {
        timeLabel.font = AppFonts.time
        timeLabel.textColor = AppColors.secondaryText
        timeLabel.textAlignment = .center
        
        statusLabel.font = AppFonts.status
        statusLabel.textAlignment = .center
        
        separatorView.backgroundColor = AppColors.separator
        
        homeLogoImageView.contentMode = .scaleAspectFit
        awayLogoImageView.contentMode = .scaleAspectFit
        
        homeTeamLabel.font = AppFonts.teamName
        awayTeamLabel.font = AppFonts.teamName
        
        homeScoreLabel.font = AppFonts.score
        awayScoreLabel.font = AppFonts.score
        
        homeScoreLabel.textAlignment = .right
        awayScoreLabel.textAlignment = .right
    }
    
    override func setupConstraints() {
        timeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(4)
            $0.width.equalTo(60)
        }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(2)
            $0.centerX.equalTo(timeLabel)
            $0.bottom.lessThanOrEqualToSuperview().inset(4)
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.equalTo(timeLabel.snp.trailing).offset(8)
            $0.width.equalTo(1)
            $0.top.bottom.equalToSuperview().inset(4)
        }
        
        homeLogoImageView.snp.makeConstraints {
            $0.leading.equalTo(separatorView.snp.trailing).offset(8)
            $0.top.equalToSuperview().offset(4)
            $0.size.equalTo(20)
        }
        
        homeTeamLabel.snp.makeConstraints {
            $0.leading.equalTo(homeLogoImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(homeLogoImageView)
        }
        
        homeScoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(homeLogoImageView)
            $0.width.greaterThanOrEqualTo(20)
        }
        
        awayLogoImageView.snp.makeConstraints {
            $0.leading.equalTo(homeLogoImageView)
            $0.top.equalTo(homeLogoImageView.snp.bottom).offset(6)
            $0.size.equalTo(20)
            $0.bottom.equalToSuperview().inset(4)
        }
        
        awayTeamLabel.snp.makeConstraints {
            $0.leading.equalTo(awayLogoImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(awayLogoImageView)
        }
        
        awayScoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(awayLogoImageView)
            $0.width.greaterThanOrEqualTo(20)
        }
    }
}
