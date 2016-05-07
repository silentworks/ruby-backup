image := silentworks/ruby-backup:latest
current_dir := $(shell pwd)
storages := local

default: build

build: Dockerfile
	docker build -t '$(image)' --rm .

generate:
	docker run --rm -v "$(current_dir)":/app -w /app $(image) sh -c 'backup generate:model \
		--config-file='/app/config.rb' --trigger $(model) --storages="$(storages)" \
		$(backup_options)'

perform:
	docker run --rm -v "$(current_dir)":/app -w /app $(image) sh -c 'backup perform -t $(model) -c="/app/config.rb"'

check:
	docker run --rm -v "$(current_dir)":/app -w /app $(image) sh -c 'backup check -c="/app/config.rb"'