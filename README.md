# ReadmeScore

Based on clayallsopp/readme-score gem. Adapt for personal needs.

## Installation

Add this line to your application's Gemfile:

    gem 'readme-score', github: 'gaetanjuvin/readme-score'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install readme-score

## Usage

Pass in a URL:

```ruby
content = File.read('./data/sample_readme.md')
score = ReadmeScore.for(content)
score.total_score
# => 95
```
