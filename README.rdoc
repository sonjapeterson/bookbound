# BookBound

BookBound was created by [Jay Hou](https://github.com/jiggoha), [Sonja Peterson](https://github.com/sonjapeterson), [E-Lynn Yap](https://github.com/elynnyap), and [Joe Calamia](https://github.com/jawaseph) as a final project for the [2014 Yale Entrepreneurial Institute's Tech Bootcamp](http://yei.yale.edu/tech). Our goal was to create an app that promotes meaningful conversation by helping users to connect over books. Check it out at [bookbound.herokuapp.com](http://bookbound.herokuapp.com/).

## How It Works

After signing in with Facebook, "Start a Book" to begin. Enter the title, ISBN, or author of an old favorite or the latest bestseller. Select what you want to read and then pick a reading partner. Pick a friend if you'd like to start a bookclub for two. Mystery lover? Pick a stranger with our "Read with a Rando" feature. BookBound's compatibility algorithm will help you find a perfect reading pal.

Once your partner accepts your request, you're off! You'll both be able to access a page where you can read and write notes keyed to particular pages in the book. You can see and respond to your friend's notes, but not on pages ahead of your current reading location. Look ma, no spoilers! See all those notes some 20 pages ahead? Better catch up to your friend to get to the good stuff.

## How We Built It

BookBound is built on Ruby on Rails. We used OmniAuth Facebook authentication to create user accounts and the Google Books API to collect book data and images. We used Foundation as our front-end framework. Tests are written with RSpec (and are a work in progress.)