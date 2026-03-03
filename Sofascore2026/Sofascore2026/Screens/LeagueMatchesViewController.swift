

import UIKit
import SofaAcademic
import SnapKit

final class LeagueMatchesViewController: UIViewController{
    
    private let dataSource = Homework2DataSource()
    private let headerView = LeagueHeaderView()
    private let contentStackView = UIStackView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.background
        setupView()
        setupLayout()
        
        loadData()
        
    }

    
    private func setupView() {
        contentStackView.axis = .vertical
        contentStackView.spacing = 12
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill
        view.addSubview(headerView)
        view.addSubview(contentStackView)
    }

    private func setupLayout() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        contentStackView.snp.makeConstraints{
            $0.top.equalTo(headerView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(16)
        }
    }

        
    private func loadData() {
        let league = dataSource.laLigaLeague()
        let events = dataSource
            .laLigaEvents()
            .sorted { $0.startTimestamp < $1.startTimestamp }
        let headerViewModel = makeLeagueHeaderViewModel(from: league)
        headerView.configure(with: headerViewModel)
        let rowViewModels = events.map{makeMatchRowViewModel(from: $0) }
        rowViewModels.forEach { viewModel in
            let rowView = MatchRowView()
            rowView.configure(with: viewModel)
            contentStackView.addArrangedSubview(rowView)
        }
    }
    
}

private extension LeagueMatchesViewController{
    
    func leagueLogoImageName(for league: League) -> String {
        switch league.id {
        case 1:
            return "laliga"
        default:
            return "placeholder"
        }
    }

    func teamLogoImageName(for team: Team) -> String {
        switch team.id {
        case 1:
            return "real_madrid"
        case 2:
            return "barcelona"
        case 3:
            return "villareal"
        case 4:
            return "mallorca"
        default:
            return "placeholder"
        }
    }
    func makeLeagueHeaderViewModel(from league: League) -> LeagueHeaderViewModel {
        LeagueHeaderViewModel(
            countryName: league.country?.name ?? "",
            leagueName: league.name,
            logoImageName: leagueLogoImageName(for: league)
        )
    }
    func makeMatchRowViewModel(from event: Event) -> MatchRowViewModel {
        MatchRowViewModel(
            timeText: formattedTime(from: event.startTimestamp),
            statusText: statusText(for: event.status),
            statusColor: statusColor(for: event.status),
            homeTeamName: event.homeTeam.name,
            awayTeamName: event.awayTeam.name,
            homeLogoImageName: teamLogoImageName(for: event.homeTeam),
            awayLogoImageName: teamLogoImageName(for: event.awayTeam),
            homeTeamScore: scoreText(from: event.homeScore),
            awayTeamScore: scoreText(from: event.awayScore),
            scoreColor: scoreColor(for: event.status)
        )
    }
    
    func formattedTime(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    func statusText(for status: EventStatus) -> String {
        switch status {
        case .finished:
            return AppStrings.finished
        case .halftime:
            return AppStrings.halftime
        case .inProgress:
            return AppStrings.live
        case .notStarted:
            return AppStrings.notStarted
        }
    }

    func statusColor(for status: EventStatus) -> UIColor {
        switch status {
        case .inProgress:
            return AppColors.accent
        case .finished, .halftime, .notStarted:
            return AppColors.secondaryText
        }
    }

    func scoreText(from score: Int?) -> String {
        guard let score else { return AppStrings.noScore }
        return String(score)
    }

    func scoreColor(for status: EventStatus) -> UIColor {
        switch status {
        case .inProgress:
            return AppColors.accent
        case .finished, .halftime, .notStarted:
            return AppColors.primaryText
        }
    }
    
    
}
