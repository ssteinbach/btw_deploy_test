GAME_NAME = metaballs
GAME_VERSION = 1.0.0

GIT = git
GITSTATUS := $(shell git diff-index --quiet HEAD . 1>&2 2> /dev/null; echo $$?)
DEV_BRANCH = $(GAME_NAME).ooo
DEPLOY_BRANCH = $(GAME_NAME).DEPLOY

ALLOW_ITCH_RELEASE=false
ITCH_GAME_NAME=$(GAME_NAME)
ITCH_RELEASE_USER=stephan-gfx
ITCH_RELEASE_FILE = $(ITCH_GAME_NAME).$(GAME_VERSION).zip

DEPLOY_USER = ssteinbach
DEPLOY_REPO_NAME = btw_deploy_test
DEPLOY_REMOTE = git@github.com:$(DEPLOY_USER)/$(DEPLOY_REPO_NAME).git

all:
	@echo "Updating all sprites..."
	@../../tools/sprite_json_generator.py -u

# this target deploys to a github repo that you can then point at with a url like:
# https://morgan3d.github.io/quadplay/console/quadplay.html?game=https://<USER_NAME>.github.io/<DEPLOY_REPO_NAME>/<GAME_NAME>.game.json
# the target needs to be something like: DEPLOY_REMOTE = git@github.com:<USER_NAME>/<DEPLOY_REPO_NAME>.git
deploy:
ifneq ($(GITSTATUS), 0)
	$(error "Git repository is dirty, cannot deploy. Run 'git status' for more info")
endif
	@echo "Moving deploy branch"
	$(GIT) checkout -B $(DEPLOY_BRANCH)
	$(GIT) reset --hard $(DEV_BRANCH)
	$(GIT) init
	$(GIT) add .
	$(GIT) commit -m "Snapshot for deployment"
	$(GIT) remote add deploy $(DEPLOY_REMOTE)
	$(GIT) push deploy master --force
	@rm -rf .git
	$(GIT) checkout $(DEV_BRANCH)
	@echo "Deploy branch is now moved." 
	@echo "To test visit: https://morgan3d.github.io/quadplay/console/quadplay.html?game=https://"$(DEPLOY_USER)".github.io/$(DEPLOY_REPO_NAME)/$(GAME_NAME).game.json"

# make a zipfile for itch
itch:
ifneq ($(ALLOW_ITCH_RELEASE), true)
	$(error "Releasing to itch is not yet allowed for this game.")
endif
ifneq ($(GITSTATUS), 0)
	$(error "Git repository is dirty, cannot deploy. Run 'git status' for more info")
endif
	@echo "running from: " $(PWD)
	@echo "Remove previous release if it exists."
	-@rm -rf $(ITCH_RELEASE_FILE)
	python3 ../../tools/export.py -z $(ITCH_RELEASE_FILE) .
	@echo "done, made $(PWD)/$(ITCH_RELEASE_FILE)"
	@echo "updating butler..."
	bash getbutler.sh
	butler/butler push $(ITCH_RELEASE_FILE) $(ITCH_RELEASE_USER)/$(ITCH_GAME_NAME):html
