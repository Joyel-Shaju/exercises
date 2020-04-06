# Four Day Engineering Practices Training - Initial Setup

## Software Installation

Open your IDE terminal and execute below commands to complete the software installation.

Note: If you are using AWS Cloud9 IDE then you should have already received AWS Console credentials and AWS Access ID & Key respectively.

```ssh
curl https://raw.githubusercontent.com/software-engineering-practices/exercises/master/scripts/ide-setup.sh --output setup.sh
```

```ssh
chmod +x setup.sh && ./setup.sh
```

This might take some time.

## Committing your changes

### Generate a new SSH key

Only required if you are going to use the ssh repository URLs.
Ask your instructor if you need to set up these.

**IMPORTANT: MAKE SURE YOU DO NOT CREATE THE RSA KEYFILES IN A DIRECTORY
THAT YOU ARE GOING TO COMMIT AND PUSH TO GITHUB**

Follow the steps here to generate a new SSH key for GitHub here:

<https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#platform-windows>

Then add the key to your account by following the steps outlined here:

<https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/#platform-windows>
