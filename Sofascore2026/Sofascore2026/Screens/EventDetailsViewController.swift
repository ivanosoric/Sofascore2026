import UIKit
import SnapKit

final class EventDetailsViewController: UIViewController {
    
    private let viewModel: EventDetailsViewModel
    
    private let tournamentLabel = UILabel()
    
    private let homeLogoImageView = UIImageView()
    private let awayLogoImageView = UIImageView()
    
    private let homeTeamLabel = UILabel()
    private let awayTeamLabel = UILabel()
    
    private let dateLabel = UILabel()
    private let timeLabel = UILabel()
    
    init(viewModel: EventDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupView() {
        view.backgroundColor = AppColors.background
        title = ""
        
        navigationItem.backButtonTitle = ""
        
        view.addSubview(tournamentLabel)
        view.addSubview(homeLogoImageView)
        view.addSubview(awayLogoImageView)
        view.addSubview(homeTeamLabel)
        view.addSubview(awayTeamLabel)
        view.addSubview(dateLabel)
        view.addSubview(timeLabel)
        
        tournamentLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        tournamentLabel.textColor = AppColors.secondaryText
        tournamentLabel.textAlignment = .left
        tournamentLabel.numberOfLines = 2
        
        homeLogoImageView.contentMode = .scaleAspectFit
        awayLogoImageView.contentMode = .scaleAspectFit
        
        homeTeamLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        homeTeamLabel.textColor = AppColors.primaryText
        homeTeamLabel.textAlignment = .center
        homeTeamLabel.numberOfLines = 2
        
        awayTeamLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        awayTeamLabel.textColor = AppColors.primaryText
        awayTeamLabel.textAlignment = .center
        awayTeamLabel.numberOfLines = 2
        
        dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        dateLabel.textColor = AppColors.primaryText
        dateLabel.textAlignment = .center
        
        timeLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        timeLabel.textColor = AppColors.primaryText
        timeLabel.textAlignment = .center
    }
    
    private func setupLayout() {
        tournamentLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        homeLogoImageView.snp.makeConstraints {
            $0.top.equalTo(tournamentLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(28)
            $0.size.equalTo(72)
        }
        
        awayLogoImageView.snp.makeConstraints {
            $0.top.equalTo(homeLogoImageView)
            $0.trailing.equalToSuperview().inset(28)
            $0.size.equalTo(72)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(homeLogoImageView).offset(8)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dateLabel.snp.bottom).offset(12)
        }
        
        homeTeamLabel.snp.makeConstraints {
            $0.top.equalTo(homeLogoImageView.snp.bottom).offset(12)
            $0.centerX.equalTo(homeLogoImageView)
            $0.width.lessThanOrEqualTo(130)
        }
        
        awayTeamLabel.snp.makeConstraints {
            $0.top.equalTo(awayLogoImageView.snp.bottom).offset(12)
            $0.centerX.equalTo(awayLogoImageView)
            $0.width.lessThanOrEqualTo(130)
        }
    }
    
    private func configure() {
        tournamentLabel.text = viewModel.tournamentText
        homeTeamLabel.text = viewModel.homeTeamName
        awayTeamLabel.text = viewModel.awayTeamName
        dateLabel.text = viewModel.dateText
        timeLabel.text = viewModel.timeText
        
        homeLogoImageView.setImage(from: viewModel.homeTeamLogoURL)
        awayLogoImageView.setImage(from: viewModel.awayTeamLogoURL)
    }
}
