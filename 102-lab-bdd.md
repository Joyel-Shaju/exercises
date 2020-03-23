# BDD Lab (Social Network)

The source material for this lab can be found at
[python-lab-bdd](https://github.com/armakuni/python-lab-bdd).

## The Exercise

Create a Social Network called Flitter, allowing users to see messages
posted from people they're interested in.

Your job is to create the message feed for a Python service which
implements the required behaviour.

During the engineering session, the first part of this lab will be led
by the facilitator, you will then be required to implement the remaining
functionality.

### Branches

  - The facilitator will start on the `master` branch
  - Attendees will be asked to checkout the `scenario4` branch
  - A final solution can be found in the `completed` branch

### The Requirements

#### Business Requirements

A user's feed should include the following messages:

  - Messages posted by the user themselves
  - Messages posted by users they follow
  - Messages which mention them (by including `@username` in a message)

All requirements have scenarios written up and commented out in
[features/message\_feed.feature](https://github.com/armakuni/python-lab-bdd/blob/master/flitter/flitter.py).

#### Technical Requirements

The provided
[Flitter](https://github.com/armakuni/python-lab-bdd/blob/master/flitter/flitter.py)
class provides the public interface to the application. Your Gherkin
tests should exercise the method on this class to test the system.

The requirements for the method in the `Flitter` class are described in
the method `docstrings`.

The exercise should be done so all state is stored in memory, however,
it should be designed in a way which allows a real database to be used
at a later date.

### How To Do The Exercise

Open the project in PyCharm and follow the instructions in the
[README.md](https://github.com/armakuni/python-lab-bdd/blob/master/README.md)
to set up the project. Then work through the following steps:

1.  Start by making the first scenario pass
2.  Proceed by un-commenting out each scenario and then making it pass
3.  Use unit tests and the TDD cycle as appropriate
4.  Take time to think about the design and refactor as you go
5.  Keep your tests green and commit regularly
