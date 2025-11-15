gitpush:
	GIT_SSH_COMMAND='ssh -i ~/.ssh/personalGit/id_ed25519' git push

backup-work-windows:
	powershell -ExecutionPolicy Bypass -File ./work/windows/backup.ps1 -Backup

backup-work-ubuntu:
	./backup.sh -b -U
