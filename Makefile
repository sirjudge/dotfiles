gitpush:
	GIT_SSH_COMMAND='ssh -i ~/.ssh/personalGit/id_ed25519' git push

backup-work:
	./backup.sh -b -w
