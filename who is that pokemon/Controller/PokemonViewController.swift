import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    
    lazy var pokemonManager = PokemonManager()
    lazy var imageManager = ImageManager()
    lazy var game = GameModel()
    
    var random4Pokemons: [PokemonModel] = [] {
        // Ejecuta una función luego de que la variable o lo que se debe obtener haya sido llenado
        didSet {
            setButtonsTittles()
        }
    }
    
    var correctAnswer: String = ""
    var correctAnswerImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Seder control a partes del código
        pokemonManager.delegate = self
        imageManager.delegate = self
        
        createButtons()
        pokemonManager.fetchPokemon()
        labelMessage.text = " "
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print(sender.title(for: .normal)!)
    }
    
    func createButtons() {
        for button in answerButtons {
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 10.0
        }
    }
    
    func setButtonsTittles() {
        // Get our 4 random name items
        for (index, button) in answerButtons.enumerated() {
            // When working with delegates and modifying an interface we have to Dispatch so it will pass throught a queue
            // Because we are waiting for the API's response
            DispatchQueue.main.async { [self] in
                button.setTitle(random4Pokemons[safe: index]?.name.capitalized, for: .normal)
            }
            
        }
            
    }
}

extension PokemonViewController: PokemonManagerDelegate {
    func didUpdatePokemon(pokemons: [PokemonModel]) {
        random4Pokemons = pokemons.choose(n: 4)
        
        let index = Int.random(in: 0...3)
        let imageData = random4Pokemons[index].imageURL
        correctAnswer = random4Pokemons[index].name
        
        imageManager.fetchImage(url: imageData)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension PokemonViewController: ImageManagerDelegate {
    func didUpdateImage(image: ImageModel) {
        print(image.imageUrl)
    }
    
    func didFailWithErrorImage(error: Error) {
        
    }
    
    
}

// Colecciones disponibvles en XCode, arrays, colecciones, etc. Vamos a iterar a travez de indices, los iteraremos
extension Collection where Indices.Iterator.Element == Index {
    // Safe para que no se vaya a indices que no existen
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}

// Para los aleatorios y cortar la cantidad que queremos, en este caso 4
extension Collection {
    func choose(n: Int) -> Array<Element> {
        Array(shuffled().prefix(n))
    }
}
