#!/bin/bash

source_dir="dmtavt.com-src"
publish_dir_rel="../chhh.github.io"
publish_branch="master"

cur_dir=${PWD##*/}

# Check that we're in the right directory to begin with
if [ "$cur_dir" != "$source_dir" ]; then
	printf"\n\nYou must be in '$source_dir' direcotry to execute this script.\n"
	exit 1
fi

# Check that publish dir exists
if [ ! -d "$publish_dir_rel" ]; then
	printf"\n\nPublishing dir does not exist: '$publish_dir_rel'.\n"
	exit 1
fi

printf "\n\nRemoving old content:\n"
rm -rf public

printf "\n\nBuilding new content...\n"
hugo


# Offer to publish changes
read -n 1 -p "Would you like to publish changes? (y/n/c)" ans;
printf "\n\n"

case $ans in
    y|Y)
		SRC=$(pwd)
		cd $publish_dir_rel
		PUB=$(pwd)
		printf "Working in $PUB\n"
		WORKTREE=$publish_dir_rel
		CHANGED=$(git --work-tree=${WORKTREE} status --porcelain)
		if [ -n "${CHANGED}" ]; then
			printf "Publishing repo has uncommitted changes\n"
		else
			printf "Publishing repo is clean, can publish new content\n"
		fi
		printf "Checking out $publish_branch, deleting old stuff, pushing new content upstream\n"
		git checkout $publish_branch
        git pull
		git rm -rf .;
		cd $SRC
		cp -r ./public/* $publish_dir_rel
		rm -rf ./public
		cd $PUB
		git add -A
		git commit -m "Contents update"
		git push
		exit;;
    n|N)
        printf "\nNot publishing changes, exiting.\n"
        exit;;
    *)
		printf "\nNot publishing changes, exiting.\n"
        exit;;
esac
