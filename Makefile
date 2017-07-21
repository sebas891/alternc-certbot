NAME=alternc-certbot
VERSION=$(shell git tag -l --points-at HEAD)
ITERATION=""

ifeq ($(strip $(VERSION)),)
	VERSION="0.0.0"
	ITERATION=`date +'%y%m%d%H%M%S'`
endif

.PHONY: clean package

all: clean package

clean:
	rm -f $(NAME)_*.deb

package:
	fpm -s dir -t deb \
		-n $(NAME) \
		-v $(VERSION) \
		--iteration $(ITERATION) \
		-m alternc@webelys.com \
		--license GPLv3 \
		--category admin \
		--architecture all \
		--depends "alternc (>= 3.3), certbot" \
		--chdir src \
		.