# Lovevery Take Home Project

This is the take-home project for engineers at Lovevery, and thanks in advance for taking the time on this.  The
goal of this project is to try to simulate some real-world work you'll do as an engineer for us, so that we can
see you write some code from the comfort of your own computer.

## Submission Instructions

1. Please clone the repo into your own **private repo** in order to complete the assignment.
1. In addition to completing the implementation that the repo describes, please **edit this README** and provide one or two paragraphs explaining what you did, why, and how you tested it. You may include ideas for future enhancement, if you have anything to call out.
1. Share your private repo with the following email addresses when you're ready for us to take a look:

```
paul@lovevery.com
ola.mork@lovevery.com
charlie.maffitt@lovevery.com
grey@lovevery.com
yanny@lovevery.com
manisha@lovevery.com
```

## The Project

This application is a *very* basic simulation of browsing our products and purchasing one of them.  The
application should work and it has tests to demonstrate that.  Much is simplified to keep the code minimal and
avoid making you deal with unnecessary complexity.

### The basic flow is:

1. Visit `/` and see the products
1. Select a product to view it
1. Click to purchase that product
1. Fill in the data needed to purchase it:
   - Your name
   - Your child's name and birthdate
   - Your address and zip code
   - Your credit card information
1. This will create an order in our system, as well as a record for your child if they are not already in the database.

What we'd like you to do is allow this app to support gifting.  Instead of a parent buying one of our products for
their child, we want you to *also* allow anyone to buy a product for any child. Imagine you are someone's aunt or
uncle and you want to get them a Lovevery product as a gift.

### There are three basic requirements:

* The gift giver can provide an optional message to the child.
* The gift giver must know the child's name and birthdate, as well as the child's parent's name, but does not need
to provide the child's shipping address or zipcode.
* The child must already be in the system, and we can use their previous order shipping information to know how to
ship the gift order.

Beyond that, it's up to you how to implement this and how it should look.

* There is no "one true answer" so write the code as you would normally for a job.
* Don't get fancy—this doesn't have to be a demonstration of every skill you have. Focus on solving the problem above as expediently as you can.  In the real world, that's what you'd do in order to get feedback and iterate.
* Make sure that a) your changes are well tested and b) you don't cause any of the existing tests to fail

Feel free to ask any questions of us, but you can simply make any assumptions you need to get moving. If you ask
us specifics about the requirements, we might say to use your best judgement.

## Getting Set Up

Assuming you have Ruby installed and are using a Ruby version manager like rvm or rbenv, you should be able to:

```
> bin/setup
> yarn install
> bin/rspec
```

This should install needed gems, set up your databases, and then run the tests, which should all pass.  If
anything is wrong at this stage and you can't obviously fix it, let us know.  This is *not* a test of your ability
to setup a Rails dev environment.

Once you have verified that you can run the specs, run both webpacker and rails server in seperate shells via:

```
> bin/webpack-dev-server
> bin/rails s
```

## Notes About The Code

We've kept this as free of third party dependencies as possible to keep things simple.  There are two main
dependencies this app uses that aren't part of Rails: Bootstrap and RSpec.

[Bootstrap](https://getbootstrap.com/) is used for styling the site so you don't have to write a bunch of CSS but
can still produce a decent-looking UI.  Hopefully you find it easy enough to use.

[RSpec](https://rspec.info) is a commonly used testing framework that we use, so we thought it was important to
put it into this project.  This is not a test of your ability to use every feature of RSpec, so if you are
unfamiliar with how it works, this is the very very basics that you need:

* `Rspec.describe`, `describe`, `RSpec.feature` create blocks of code and are for organization only.  They have no
other purpose
* `it` and `scenario` create blocks of code that *are* the test cases.  Each test case should be given to an `it`
or `scenario` block, and this app has many examples to follow.
* To assert things in your tests, you would write `expect(«thing to assert»).to eq(«value you expect it to be»)`, for example `expect(4 + 4).to eq(8)`.  RSpec has *many* (many) more ways to assert things, but if all you use is this one mechanism, you are fine.

Finally, while we tried to write a clean and well-tested app for you, we will go ahead and admit now that it's not
perfect and there are things that could be improved.  We might ask you about your thoughts on some of this code
later, but this is all part of the scenario - real-world code is never as nice as we'd like.

## My Implementation
I satisfied the requirements of this project by creating a separate flow for gift giving. When the user views the product show page, they can now select to either "Buy Now" or "Send Gift". If they select "Send Gift", they will be taken to the new gift order page, a variation of the order page, where they can input their name, the name and birthdate of the child they wish to send the gift to, the name of the parent of that child, and their credit card information. They can also optionally include a message with their gift. Once they submit their gift order, they will be taken to the new gift order confirmation page, a variation of the order confirmation page, where they will see the usual information confirming their order along with their message, if they submitted one. 

On the backend, this gifting experience is handled by a separate model, view, and controller. I chose this approach because it separates concerns and keeps the original order flow simple. Also, I was specifically asked not to implement a simple boolean solution :)

Additionally, I fixed a bug where the application would throw an error if the order form was submitted with no birthdate value or an invalid date format. I did not fix this for the original order form because it would have required refactoring of the order controller and that was beyond the scope of this project. 

Things to consider in the future:
 - Add better validation to form so that each field is checked if required and all cases are handled gracefully.
 - Handle the unlikely case where there are multiple orders with the same child, birthdate, and parent name but different addresses.
 - Make it easier for users to send gift to child. Currently, they have to guess which parent the child's record is under if the child has multiple parents. Maybe having a unique code that parents could share or having accounts that are tied to phone numbers that could sync with gift giver's contacts. This would also address the previous edge case as the address info would be tied to a unique identifier. 
  - As the application grows and new features are added, we will have to maintain two separate flows for gift giving and normal orders. This is not scalable. We should refactor to consolidate both flows into one, possibly using a checkbox to indicate that the order is a gift. Once the checkbox is selected, a field for the parent's name would appear and the address and zipcode fields would disappear or be disabled. This would make the code more DRY, but also more complex. However, we could implement helper or service classes to keep the controller clean and simple. 