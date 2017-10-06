pkg_name=rordit
pkg_origin=core
pkg_scaffolding="core/scaffolding-ruby"
pkg_version="0.1.0"

declare -A scaffolding_env
scaffolding_env[SECRET_KEY_BASE]="{{cfg.secret_key_base}}"

