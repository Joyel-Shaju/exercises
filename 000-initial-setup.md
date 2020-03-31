# Four Day Engineering Practices Training - Initial Setup

In order to complete the training exercise we will require some additional softwares and configuration being setup in your IDE.
Please follow the instructions given below and ask for help if you any problem setting up the same.

## Installation
Open your IDE terminal and execute below commands to complete the software installation.

Note: If you are using AWS Cloud9 IDE then you should have already received AWS Console credentials and AWS Access ID & Key respectively.

```ssh
curl https://raw.githubusercontent.com/software-engineering-practices/exercises/master/scripts/ide-setup.sh --output setup.sh

chmod +x setup.sh | ./setup.sh
```
This might take some time based on your internet speed.

## Committing your changes

### Generate a new SSH key

**IMPORTANT: MAKE SURE YOU DO NOT CREATE THE RSA KEYFILES IN A DIRECTORY
THAT YOU ARE GOING TO COMMIT AND PUSH TO GITHUB**

Follow the steps here to generate a new SSH key for GitHub here:

<https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#platform-windows>

Then add the key to your account by following the steps outlined here:

<https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/#platform-windows>
