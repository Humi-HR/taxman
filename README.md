# Taxman

Theme song: [Taxman](https://www.youtube.com/watch?v=l0zaebtU-CA)

## 2023

All the 2023 numbers come from the [CRA](https://www.canada.ca/en/revenue-agency/services/forms-publications/payroll/t4127-payroll-deductions-formulas/t4127-jan/t4127-jan-payroll-deductions-formulas-computer-programs.html#toc38).

## Release flow and installation

The release flow of the gem depends on the `release-please` Github Action,
which uses commit message prefixes to update the semantic version number
(`major.minor.patch`) and create a release like `v[major].[minor].[patch]`.

Prepend your commit message with:
  - `feat:` For feature changes bumping the minor version
  - `fix:` For bug fixes bumping the patch version
  - `feat!:` For feature changes bumping the major version
  - `fix!:` For bug fixes bumping the major version

A new PR will be opened once at least one feature or fix has been merged. This
PR will:
  - Bump the version number based on the merged content since last release
  - Generate new CHANGELOG.md entries

After this release PR has been merged, a release will be generated from an
automatic github action, creating the gem that can be installed either manually
or via the gemserver path.

To manually install the gem (legacy, though still used for a short while more):

1. From `payroll/`, run `gem unpack taxman-$VERSION.gem --target vendor/gems/`
1. From `payroll/`, run `bundle update taxman`
1. Remove the old version from `payroll/vendor/gems/taxman-$OLD-VERSION` - `git rm -r vendor/gems/taxman-$OLD-VERSION`

Process to be improved!

## Usage

To calculate the taxes for a given employee and period, there are five helper classes you must construct.

  - PeriodInput
  - YearInput
  - TD1 Input
  - CPPInput
  - EiInput

These build the required parameters for tax calculation.  Once constructed, pass these to `Taxman2023::Calculate` and call `call`.  You will receive back a hash with the keys `federal_taxes`, `provincial_taxes`, `employee_cpp`, `employer_cpp`, `total_bonus_taxes`, `employer_ei` and `employee_ei` - the values will be BigDecimal dollar amounts.  The return hash will also contain the details of the tax calculation - these can be stored and inspected for debugging purposes.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to (Gem host TBD).
