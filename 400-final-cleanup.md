# Final Cleanup

\#\# RSA keys

If you pushed your changes to GitHub and you are no longer going to be
using the machine you have been working on, you must delete the RSA keys
and remove them from your GitHub account.

From GitBash:

```bash
rm -rf ~/.ssh/*
```

## DockerHub on the command line

You will also need to log out of DockerHub on the command line:

```bash
docker logout
```

\#\# Clean up Docker

To remove all artefacts from Docker, run the following from GitBash

```bash
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker image prune -a
```

## Browser

You will also need to log out of the DockerHub and GitHub UI's. You can
also simply clear all cached / downloaded content from the browser you
have used.

## Files

If you can also remove any files and directories you have created as
part of the course, that would be very helpful.
