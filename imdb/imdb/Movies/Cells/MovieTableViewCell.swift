import UIKit

class MovieTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MovieTableViewCell"
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieYearLabel: UILabel!
    @IBOutlet private weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        UIView.animate(withDuration: 0.2) {
            if highlighted {
                self.movieTitleLabel.textColor = UIColor.orange
            } else {
                self.movieTitleLabel.textColor = UIColor.black
            }
        }
    }
    
    func setupCell(withModel model: Movies.Movie.ViewModel.MovieViewModel) {
        movieTitleLabel.text = model.title
        movieYearLabel.text = model.releaseYear
        movieRatingLabel.text = model.rating
        movieDescriptionLabel.text = model.description
        loadPosterImage(posterPath: model.posterPath.getImageURL(quality: .high))
    }
    
    private func loadPosterImage(posterPath: String) {
        guard let url = URL(string: posterPath) else {return}
        movieImageView.setImage(url: url, placeHolderImage: UIImage.placeholderImage)
    }
}
