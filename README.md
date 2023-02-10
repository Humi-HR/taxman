# Taxman

Theme song: [Taxman](https://www.youtube.com/watch?v=l0zaebtU-CA)

Hopefully Taxman works out better for us than waxman :(

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add taxman

## Usage

To calulate the taxes for a given employee and period, there are five helper classes you must construct.

  - PeriodInput
  - YearInput
  - TD1 Input
  - CPPInput
  - EiInput

These build the required parameters for tax calculation.  Once constructed, pass these to `Taxman2023::Calculate` and call `call`.  You will receive back a hash with the keys `federal_taxes`, `provincial_taxes`, `employee_cpp`, `employer_cpp`, `total_bonus_taxes`, `employer_ei` and `employee_ei` - the values will be BigDecimal dollar amounts.  The return hash will also contain the details of the tax calculation - these can be stored and inspected for debugging purposes.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to (Gem host TBD).
