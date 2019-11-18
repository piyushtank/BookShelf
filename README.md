# BookShelf

BookShelf is an iOS UI representation of REST results returned by `api.itbook.store`. The app implements following threee main functionalities - 
1. New Books
2. Search Books
3. Details


## Code organization

### Model

`Book` class represents a book. The Book follows builder pattern for creation.

### UI

The app is implemented using the storyboard UI. The app has three main View Controller -

1. NewBooksViewController
2. SearchBooksViewController
3. DetailsViewController

##### Home Screen 

Upon launching the app you will see tab bar with `NewBooksViewController` and `SearchBooksViewController` embedded in it.


#### SearchBooksViewController

The `SearchBooksViewController` is a table view controller which makes a REST query to `https://api.itbook.store/1.0/search/{query}/{page}`, and displays the received new books on table view controller. The `NewBooksViewController` is embedded into navigation view controller, and navigates to details of the book when user taps on a table view cell.

The `SearchBooksViewController` fetches books in parallel in background until the complete search results are received.

#### NewBooksViewController

The `NewBooksViewController` is a table view controller which makes a REST query to `https://api.itbook.store/1.0/new`, and displays the received new books on table view controller. The `NewBooksViewController` is embedded into navigation view controller, and navigates to details of the book when user taps on a table view cell. Please note that, at present, `NewBooksViewController` doesn't  support displaying more than 10 records on screen.

### DetailsViewController

The `DetailsViewController` is view controller displays fetches the details of the book by making a REST query to `https://api.itbook.store/1.0/books/{isbn13}`. The view controller has a hyperlink fore more details.

### REST Utils

`BookStoreUtils` class is a util class for making REST query on a background queue and parsing the json respose. 

## Tests

### TODOs

At present the repod does not contain any tests -

- [ ] Write test cases for proper main thread usage
- [ ] Write UI integration test cases for app flow
- [ ] Prepare Json responses for new books, details and search to validate the view controller functionalities.
- [ ] Mock tests for TableViews and DataSource 

