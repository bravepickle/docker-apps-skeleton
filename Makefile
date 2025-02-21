# Helper methods for working with GO application

# Color settings
CL_RED := \033[31m
CL_GREEN := \033[32m
CL_YELLOW := \033[33m
CL_BLUE := \033[34m
CL_RESET := \033[0m

# Disable coloring output
ifeq ($(NOCOLOR),1)
	CL_RED =
    CL_GREEN =
    CL_YELLOW =
    CL_RESET =
endif

# Build script arguments
APP_BUILD_ARGS ?=

.DEFAULT_GOAL := all
.PHONY: all help

# prepare and run application
all: install update

# list available Makefile targets
help:
	@echo "$(CL_YELLOW)Available targets:$(CL_RESET)"
	@awk '/^[a-zA-Z_-]+:/ {print substr($$1, 1, length($$1)-1)}' $(MAKEFILE_LIST)

# setup application wizard. Run at the initial setup
.PHONY: setup
setup:
	@echo "$(CL_YELLOW)=> Running application setup...$(CL_RESET)"
	@echo "$(CL_YELLOW)Step 1.$(CL_RESET) Create $(CL_GREEN).env$(CL_RESET) file based on $(CL_GREEN).env.dist$(CL_RESET) config and customize settings. Press enter to continue."
	@read reply

	@echo "$(CL_YELLOW)Step 2.$(CL_RESET) Install GO - $(CL_BLUE)https://go.dev/dl/$(CL_RESET). Then, press enter"
	@read reply
	go install 'github.com/bravepickle/templar@latest'
	@echo ""

	$(MAKE) template
	@echo "$(CL_YELLOW)Step 3.$(CL_RESET) Copy file contents \"etc/common/hosts\" to your hosts config. E.g. 'cat etc/common/hosts >> /etc/hosts'. Then, press enter"
	@read reply

	@#echo "$(CL_YELLOW)Step 4.$(CL_RESET) Initialising app..."
	@#docker compose exec -u root <container_app> /initapp.sh

	@echo "$(CL_YELLOW)Finished successfully!$(CL_RESET)"

# install project apps
install:
	@echo "$(CL_YELLOW)=> Installing app...$(CL_RESET)"
	bin/install_apps.sh

# run application
run:
	@echo "$(CL_YELLOW)=> Starting app...$(CL_RESET)"
	docker compose start

# make self-signed certificates
cert:
	@echo "$(CL_YELLOW)=> Making SSL certs...$(CL_RESET)"
	bin/make_self_signed_cert.sh

# build templates
template:
	@echo "$(CL_YELLOW)=> Building templates...$(CL_RESET)"
	bin/build_templates.sh

# update dependencies & application
update:
	@echo "$(CL_YELLOW)=> Updating app...$(CL_RESET)"
	bin/update_apps.sh

# upgrade app version. Updates APP_VERSION option, if needed and notifies user. No big changes to the code
upgrade:
	@echo "$(CL_YELLOW)=> Upgrading app...$(CL_RESET)"
	bin/upgrade_app.sh
