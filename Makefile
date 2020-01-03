GIT = git
GITSTATUS := $(shell git diff-index --quiet HEAD . 1>&2 2> /dev/null; echo $$?)
SPRITES = bombgoblin.png splode.png driz_anim1.png
DEPLOY_BRANCH = "DEPLOY_BTW"
DEV_BRANCH = "beat_the_wizard"
THIS_DIR = "_alpha/beat_the_wizard"
DEPLOY_REMOTE = git@github.com:ssteinbach/btw_deploy_test.git

all:
	@echo "Updating all sprites..."
	@../../tools/sprite_json_generator.py -u

deploy:
ifneq ($(GITSTATUS), 0)
	$(error "Git repository is dirty, cannot deploy. Run 'git status' for more info")
endif
	@echo "Moving deploy branch"
	$(GIT) checkout $(DEPLOY_BRANCH)
	$(GIT) reset --hard $(DEV_BRANCH)
	$(GIT) init
	$(GIT) add .
	$(GIT) commit -m "Snapshot for deployment"
	$(GIT) remote add deploy $(DEPLOY_REMOTE)
	$(GIT) push deploy master --force
	@rm -rf .git
	$(GIT) checkout $(DEV_BRANCH)
	@echo "Deploy branch is now moved." 


# sprites: $(SPRITES)
#
#
# prep_sprites: $(wildcard *.png)
#
#
