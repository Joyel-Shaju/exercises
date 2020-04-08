# Deploying the Microservices

For days 3 and 4, you'll be working on a provided Microservice
Architecture. This guide takes you through the process of getting all
the services up and running with Jenkins and Kubernetes.

## 1\. Fork the repositories

We're going to need our own versions of the codebase so that we can
update the config and develop new features.

Start by forking each of the following repositories to your GitHub
account.

### Infrastructure Repository

- **[banking-app-infrastructure](https://github.com/software-engineering-practices/banking-app-infrastructure)**

### Microservice Repositories

- **[account-service](https://github.com/software-engineering-practices/account-service)**
- **[cashier-service](https://github.com/software-engineering-practices/cashier-service)**
- **[balance-service](https://github.com/software-engineering-practices/balance-service)**
- **[customer-service](https://github.com/software-engineering-practices/customer-service)**
- **[transaction-service](https://github.com/software-engineering-practices/transaction-service)**

### Smoke Test Repository

- **[banking-app-smoketest](https://github.com/software-engineering-practices/banking-app-smoketest)**

## 2\. Clone all the repositories locally

### 2.1 Create a working directory

If it does not already exist, please create a directory on the machine
with the following command:

```cmd
mkdir $HOMEPATH/Code
mkdir $HOMEPATH/Code/day-3
```

Next, move into the directory:

```cmd
cd $HOMEPATH/Code/day-3
```

### 2.2 Clone all the following repositories

In your Git Bash terminal, `cd` to your local projects directory and run
the following commands:

```cmd
export GITHUB_ID=<GITHUB_ID>
git clone git@github.com:$GITHUB_ID/banking-app-infrastructure
git clone git@github.com:$GITHUB_ID/account-service
git clone git@github.com:$GITHUB_ID/cashier-service
git clone git@github.com:$GITHUB_ID/balance-service
git clone git@github.com:$GITHUB_ID/customer-service
git clone git@github.com:$GITHUB_ID/transaction-service
git clone git@github.com:$GITHUB_ID/banking-app-smoketest
```

## 3\. Start Locally with `docker-compose`

In a terminal, `cd` into the `banking-app-smoketest` directory and run:

```cmd
docker-compose up
```

> `docker-compose` is a too which allows allows you to create
> multi-container applications. The containers that are create are
> defined in the `docker-compose.yml` file.

Once the services have started (and the message settle down), you should
be able to run the smoke test.

In another terminal window, `cd` into the `banking-app-smoketest`
directory and run:

    pipenv install --dev
    pipenv run behave

If all goes well, the test should pass and you should see some messages
logged out in the `docker-compose` window.

When you are done, you can press `Ctrl+C` to stop the `docker-compose`
session.

## 4\. Create Infrastructure Job

### Update the config

Open the `Jenkinsfile` in the `banking-app-infrastructure` repository
and update the `github_id` at the top to match the Github ID that you
forked the repository to.

Then commit and push the change.

> ### Take a Moment to Review the Repository
>
> This Jenkinsfile simply uses `kubectl` to apply the manifest in the
> `kubernetes/` directory. The `ingress.yml` manifest sets up the routes
> into the app and the Jenkins pipeline substitutes the host names with
> ones generated from your GitHub ID.

### Create the Job

1.  Log into Jenkins and click the `New Item` link at the top of the
    menu on the left.
2.  Enter `GITHUB_ID-banking-app-infrastructure` as the item name.
3.  Select `Pipeline` as the type and click `OK`.
4.  Select `Poll SCM` under `Build Triggers` and enter `* * * * *`
    (every minute) into the `Schedule` text area.
5.  Select `Pipeline script from SCM` as the pipeline definition.
6.  Select `Git` from the `SCM` drop down.
7.  Enter `https://github.com/GITHUB_ID/banking-app-infrastructure.git`
    as the `Repository URL`.
8.  Press `Save`.
9.  Click the `Build Now` link to kick of the job - hopefully it will
    succeed.

If the build passes then you should be able to visit
`http://GITHUB_ID-rabbit.apps.prod.practices.armakuni.co.uk` in a browser and see the
RabbitMQ management control panel (user: `guest` / pass: `guest`).

## 5\. Create Service Jobs

Perform the following steps for each of the 5 microservice repositories:

1.  Open the `Jenkinsfile` for each service and update the `github_id`
    to match the Github ID that you forked the repository to.
2.  Commit and push the change.
3.  Click the `New Item` link at the top of the menu on the left of the
    Jenkins dashboard.
4.  Enter `GITHUB_ID-REPOSITORY_NAME` as the item name
    (e.g.\`armakuni-account-service).
5.  Select `Pipeline` as the type and click `OK`.
6.  Select `Poll SCM` under `Build Triggers` and enter `* * * * *`
    (every minute) into the `Schedule` text area.
7.  Select `Pipeline script from SCM` as the pipeline definition.
8.  Select `Git` from the `SCM` drop down.
9.  Enter `https://github.com/GITHUB_ID/REPOSITORY_NAME.git` as the
    `Repository URL`.
10. Press `Save`.
11. Click the `Build Now` link to kick of the job - hopefully it will
    succeed.
12. Ensure the job runs successfully.

## 6\. Create Smoke Test Job

Finally, we need to set up the smoke test job. We'll configure this job
to run after any of the others have completed. To do this, complete the
following steps:

1.  Open the `Jenkinsfile` for the smoke test job and update the
    `github_id` to match the Github ID that you forked the repository
    to.
2.  Click the `New Item` link at the top of the menu on the left of the
    Jenkins dashboard.
3.  Enter `GITHUB_ID-banking-app-smoketest` as the item name.
4.  Select `Pipeline` as the type and click `OK`.
5.  Select `Build after other projects are built` and enter your 6 other
    jobs as the `Projects to watch`.
6.  Select `Poll SCM` under `Build Triggers` and enter `* * * * *`
    (every minute) into the `Schedule` text area.
7.  Select `Pipeline script from SCM` as the pipeline definition.
8.  Select `Git` from the `SCM` drop down.
9.  Enter `https://github.com/GITHUB_ID/banking-app-smoketest.git` as
    the `Repository URL`.
10. Press `Save`.
11. Click the `Build Now` link to kick of the job - hopefully it will
    succeed.
12. Ensure the job runs successfully.

## 7\. Interacting With the Services

> All of these commands need to be run from Git Bash in order for them
> to work correctly.

### Creating a Customer

```cmd
curl -X POST http://GITHUB_ID-app.apps.prod.practices.armakuni.co.uk/customers/ -H 'Content-Type: application/json' -d '{"firstName": "Joe", "surname": "Bloggs"}'
```

### Fetching a Customer

```cmd
curl -X GET http://GITHUB_ID-app.apps.prod.practices.armakuni.co.uk/customers/CUSTOMER_ID
```

### Create an Account

```cmd
curl -X POST http://GITHUB_ID-app.apps.prod.practices.armakuni.co.uk/accounts/ -H 'Content-Type: application/json' -d '{"customerId": "CUSTOMER_ID"}'
```

### Fetch an Account

```cmd
curl -X GET http://GITHUB_ID-app.apps.prod.practices.armakuni.co.uk/accounts/ACCOUNT_NUMBER
```

**Note:** ACCOUNT_NUMBER must be 8 digits

### Make a Transaction

```cmd
curl -X POST http://GITHUB_ID-app.apps.prod.practices.armakuni.co.uk/cashier/create -H 'Content-Type: application/json' -d '{"accountNumber": "ACCOUNT_NUMBER", "amount": 100, "operation": "credit"}'
```

| Field           | Values                        |
| --------------- | ----------------------------- |
| `accountNumber` | **Must** be an 8 digit string |
| `amount`        | **positive integer**          |
| `operation`     | `debit` or `credit`           |

### Check the Balance

```cmd
curl -X GET http://GITHUB_ID-app.apps.prod.practices.armakuni.co.uk/balance/ACCOUNT_NUMBER
```

**Note:** ACCOUNT_NUMBER must be 8 digits
