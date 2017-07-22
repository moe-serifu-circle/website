#!/bin/bash

################################################################################
# deploy.sh                                                                    #
# ---------                                                                    #
# Builds the site with hugo and adds a new commit to the website server        #
# repository that includes the new files. The commit is then pushed to the     #
# origin of the server repository.                                             #
#                                                                              #
#                                                                              #
# Use options to change the message that is used in the commit. If no option   #
# is given, the terminal will be queried for one.                              #
#                                                                              #
#  -n                                                                          #
#       Use the last commit message of this source repository.                 #
#                                                                              #
#  -m <message>                                                                #
#       Use the given message.                                                 #
#                                                                              #
################################################################################

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

deploy_repo=moe-serifu-circle/moe-serifu-circle.github.io
deploy_branch=master
deploy_dir=.build
publish_dir=public

ERROR_GIT=1
ERROR_FS=2
ERROR_HUGO=3
ERROR_ARGS=4

function error()
{
	echo -e "\033[0;31m$1\033[0m" >&2
}

function check_permissions()
{
	local check_dir
	if [ $# -lt 1 ]
	then
		check_dir=.
	else
		check_dir="$1"
	fi

	if [ ! -d "$check_dir" ]
	then
		error "not a directory: $check_dir"
		exit 1
	fi
	if [ ! -w "$check_dir" ]
	then
		error "not writable: $check_dir"
		exit 1
	fi
	if [ ! -r "$check_dir" ]
	then
		error "not readable: $check_dir"
		exit 1
	fi
}

# get commit message to use
message_set=
commit_message=
if [ $# -ge 1 ]
then
	if [ "$1" == '-n' ]
	then
		commit_message="$(git log -1 --pretty=%B)"
		message_set=1
	elif [ "$1" == '-m' ]
	then
		[ $# -ge 2 ] || { error "-m requires a message" ; exit $ERROR_ARGS ; }
		commit_message="$2"
		message_set=1
	fi
fi

if [ -z "$message_set" ]
then
	echo "Message for deploy commit (leave empty to use last commit in source repo):"
	read commit_message
	if [ -z "$commit_message" ]
	then
		commit_message="$(git log -1 --pretty=%B)"
	fi
	message_set=1
fi

# if the deploy repo is not cloned, do it now
if [ ! -e "$deploy_dir" ]
then
	echo "Deploy dir is missing; cloning..."
	git clone "git@github.com:$deploy_repo.git" "$deploy_dir" || { error "could not clone repo: $deploy_repo" ; exit $ERROR_GIT ; }
fi

# make sure deploy dir is a valid directory
check_permissions "$deploy_dir" || exit $ERROR_FS

# now build with hugo
hugo || { error "could not build site" ; exit $ERROR_HUGO ; }

# make sure publish dir is a valid directory
check_permissions "$publish_dir" || exit $ERROR_FS

# copy it into the build dir and commit it
cd "$deploy_dir"
git fetch || { error "could not perform fetch on deployment repo" ; exit $ERROR_GIT ; }
git checkout "$deploy_branch" || { error "could not checkout branch $deploy_branch" ; exit $ERROR_GIT ; }
git pull || { error "could not pull branch $deploy_branch" ; exit $ERROR_GIT ; }
cd ..
cp -R "$publish_dir"/* "$deploy_dir" || { error "could not copy site into deploy dir" ; exit $ERROR_FS ; }
cd "$deploy_dir"
git add . || { error "could not stage new files for commit" ; exit $ERROR_GIT ; }
git commit -m "$commit_message" || { error "could not create commit" ; exit $ERROR_GIT ; }
git push origin "$deploy_branch" || { error "could not push commit" ; exit $ERROR_GIT ; }
cd ..

