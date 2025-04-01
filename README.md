## Instructions

1. Run `bundle install`
2. Run script `ruby ./calculator.rb`
3. Input data line by line, confirmed by [ENTER], when finished type `q` and confirm (look at the example):
```
Please list your products one by one in following fashion: {number} {name of the product} at {price for one item} 
When you finish please insert `q` and hit enter to calulate

1 imported box of chocolates at 10.00 [ENTER]
1 imported bottle of perfume at 47.50 [ENTER]
q [ENTER]
```
4. Results will be displayed as in requirements.

## Tests

There are specs confirming proper functioning of application using Rspec.

To run tests use:
`rspec specs`

## Assumptions

### Wordlists

This app requires proper identification of origin of products. I resolved this by using wordlists found in Github.
Solution is far from perfect as some needed words are missing and some that shouldn't be there.
Because of that all 3 example inputs are working, but if someone uses something different product there might be case where it won't be found in wordlist and tax will be different than expected. 

### Validations

Users might put completly random things into $stdin. I haven't added any validations regarding input and I made an assumption that user will insert correct data (to save time).
If that would be commertial level application then proper validation of data would be necessary. 

### Refactoring

I tried to add as clean code as possible, but with more time I would for sure check couple extra things and try to optimize code as much as possible. 
