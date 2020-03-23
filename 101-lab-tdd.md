# TDD Lab (Doorbell Application)

In this exercise, your goal is to write the program for a fancy
doorbell. This door bell listens for knocks on the door and then decides
what sound to play.

Your program should be a simple function that takes an **integer** (the
number of knocks) as the input and returns a **string** (describing the
sound to be played).

## Doorbell Behaviour

  - If the number of knocks is divisible by 3 output `Ding`.
  - If the number of knocks is divisible by 5, output `Dong`.
  - If the number of knocks is divisible by 3 and 5, output `DingDong`.
  - If the number of knocks is not divisible by 3 or 5, just pass the
    number's digits straight through as a string (and that amount of
    knocks will be played).

### Example

| Input | Output     |
| ----- | ---------- |
| 1     | `1`        |
| 2     | `2`        |
| 3     | `Ding`     |
| 4     | `4`        |
| 5     | `Dong`     |
| 6     | `Ding`     |
| ...   | ...        |
| 15    | `DingDong` |

## Getting Started

The
[python-lab-doorbell](https://github.com/armakuni/python-lab-doorbell)
repository provides a simple Python project to start from. It has
`pytest` (a simple Unit Testing framework) installed, an example test
and the template for your function.

### Rules

  - Use Ping-Pong Pair Programming
    1.  Person A writes a test
    2.  Person B makes the test pass and then writes the next test
    3.  Person A makes that test pass and then writes the next test
    4.  And so on
  - Work exclusively using the TDD cycle
      - **Red** - write a failing test
      - **Green** - write *only enough code to make the test pass*
      - **Refactor** - improve the code *without changing the behaviour*

### Working directory and code

#### Create a working directory

If it does not already exist, please create a directory on the machine
with the following command:

``` cmd
mkdir %HOMEDRIVE%%HOMEPATH%\Code
mkdir %HOMEDRIVE%%HOMEPATH%\Code\day-1
```

Next, move into the directory:

``` cmd
cd %HOMEDRIVE%%HOMEPATH%\Code\day-1
```

#### Checkout the code

You will now need to fork the `python-lab-doorbell` exercise from
Armakuni's GitHub account. To do this, log into your GitHub account in
the web UI and navigate to:

    https://github.com/armakuni/python-lab-doorbell

In the top right hand corner, you will find a button that says `Fork`.
Click this and it will automatically fork the repository into your
account. If you have problems doing so, please follow this guide:

    https://help.github.com/articles/fork-a-repo/#platform-windows

You should now be able to access the repo in your own account. Follow
the link below, replacing `GITHUB_ID` with your GitHub ID:

    https://github.com/GITHUB_ID/python-lab-doorbell

This should take you to your fork. Next you should checkout this fork
into your working directory by running the following command, replacing
`GITHUB_ID` with your GitHub ID:

``` cmd
cd %HOMEDRIVE%%HOMEPATH%\Code\day-1
git clone https://github.com/GITHUB_ID/python-lab-doorbell
```

This should have cloned the code into your working directory. You can
now browse the code with your editor.

#### Install the project dependencies

Run the following commmands:

``` cmd
cd python-lab-doorbell
pipenv install --dev
```

#### Run the tests

Use the following command to run the tests:

``` cmd
pipenv run python -m pytest
```

**Note**: The first test will fail.

#### Open the Project in PyCharm

1.  Open PyCharm
2.  Choose `Open` (from the Welcome to PyCharm dialog or the `File`
    menu)
3.  Naviage to the `python-lab-doorbell` directory and click `Open`

You can find the test in `test_doorbell.py` and the `ring` function in
`doorbell.py`.

#### Make the first test pass

The first test is failing because it expects a string to be return, but
the function returns `None` (the type that python returns when the body
of a function is `pass`).

To make this test pass, update the `ring` function like so:

``` python
def ring(number_of_knocks):
    return ''
```

#### Complete the implementation

Now, using ping-pong pairing and the TDD cycle, implement the complete
behaviour.

-----

## Extra: New Behaviour

If you have completed the exercise and have time remaining, you can work
on this next requirement.

We've decided that we want the bell to behave a bit differently. It
should now work in the following way:

  - If the number of knocks is divisible by 3 output `Ding`.
  - If the number of knocks is divisible by 5, output `Dang`.
  - If the number of knocks is divisible by 7, output `Dong`.
  - If the number of knocks is divisible by 3 and 5, output `DingDang`.
  - If the number of knocks is divisible by 3 and 7, output `DingDong`.
  - If the number of knocks is divisible by 5 and 7, output `DangDong`.
  - If the number of knocks is divisible by 3, 5 and 7, output
    `DingDangDong`.
  - If the number of knocks is not divisible by 3, 5 or 7 just pass the
    number's digits straight through as a string (and that amount of
    knocks will be played).
