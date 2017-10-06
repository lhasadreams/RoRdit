pkg_name=rordit
pkg_origin=core
pkg_scaffolding="core/scaffolding-ruby"
pkg_version="0.1.0"

pkg_binds=(
  [database]="port superuser_name superuser_password"
)

declare -A scaffolding_env
scaffolding_env[SECRET_KEY_BASE]="{{cfg.secret_key_base}}"
scaffolding_env[SITE_TITLE]="{{cfg.site_title}}"
scaffolding_env[SITE_SLOGAN]="{{cfg.site_slogan}}"
