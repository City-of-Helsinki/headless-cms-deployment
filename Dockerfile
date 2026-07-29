FROM helsinki.azurecr.io/openshift-wordpress-base:latest

ARG MOUNT_SECRET="false"
ARG COMPOSER_AUTH="{}"

# build volume auth
RUN mkdir -p /opt/app-root/src/.config/composer && \
    if [ -n "$MOUNT_SECRET" ] && [ "${MOUNT_SECRET,,}" = "true" ]; then \
        cp /mnt/secrets/* /opt/app-root/src/.config/composer; \
    fi

# Define theme version
ARG WP_THEME_VERSION_HEADLESS=""

# Define plugin versions
ARG WP_PLUGIN_VERSION_ACTIVITY_LOG=""
ARG WP_PLUGIN_VERSION_AUTODESCRIPTION=""
ARG WP_PLUGIN_VERSION_DUPLICATE_POST=""
ARG WP_PLUGIN_VERSION_FILEBIRD_PRO=""
ARG WP_PLUGIN_VERSION_HKIH_CPT_COLLECTION=""
ARG WP_PLUGIN_VERSION_HKIH_CPT_CONTACT=""
ARG WP_PLUGIN_VERSION_HKIH_CPT_LANDING_PAGE=""
ARG WP_PLUGIN_VERSION_HKIH_CPT_RELEASE=""
ARG WP_PLUGIN_VERSION_HKIH_CPT_SPORTSLOCATIONS=""
ARG WP_PLUGIN_VERSION_HKIH_CPT_TRANSLATION=""
ARG WP_PLUGIN_VERSION_HKIH_LINKEDEVENTS=""
ARG WP_PLUGIN_VERSION_POLYLANG_PRO=""
ARG WP_PLUGIN_VERSION_PUBLISHPRESS_REVISIONS_PRO=""
ARG WP_PLUGIN_VERSION_QUERY_MONITOR=""
ARG WP_PLUGIN_VERSION_REDIS_CACHE=""
ARG WP_PLUGIN_VERSION_REGENERATE_THUMBNAILS=""
ARG WP_PLUGIN_VERSION_SVG_SUPPORT=""
ARG WP_PLUGIN_VERSION_WORDPRESS_IMPORTER=""
ARG WP_PLUGIN_VERSION_WP_ALL_IMPORT_PRO=""
ARG WP_PLUGIN_VERSION_WP_GRAPHQL_CACHE=""
ARG WP_PLUGIN_VERSION_WP_GRAPHQL_JWT_AUTHENTICATION=""
ARG WP_PLUGIN_VERSION_WP_GRAPHQL_POLYLANG=""
ARG WP_PLUGIN_VERSION_WPO365_LOGIN=""
ARG WP_PLUGIN_VERSION_WPO365_LOGIN_PREMIUM=""
ARG WP_PLUGIN_VERSION_WP_SENTRY_INTEGRATION=""

# Define must-use plugin versions
ARG WP_PLUGIN_VERSION_ACF_CODIFIER=""
ARG WP_PLUGIN_VERSION_ADVANCED_CUSTOM_FIELDS_PRO=""
ARG WP_PLUGIN_VERSION_STREAM=""
ARG WP_PLUGIN_VERSION_WP_DEFINE_MORE=""
ARG WP_PLUGIN_WP_GENIEM_PROJECT_BELLS_AND_WHISTLES=""
ARG WP_PLUGIN_VERSION_WP_GENIEM_ROLES=""
ARG WP_PLUGIN_WP_GRAPHQL=""
ARG WP_PLUGIN_VERSION_WPS=""
ARG WP_PLUGIN_VERSION_WP_SANITIZE_ACCENTED_UPLOADS=""

# Install plugins via Composer
RUN composer config --json --merge policy.advisories.ignore-id '{"PKSA-xwpn-zs9j-6wy5":"Plugin requires specific version","PKSA-sf9j-1gs7-xzvx":"Plugin requires specific version","PKSA-7h5p-prw9-w5nr":"Plugin requires specific version"}' && \
    composer config repositories.headless-hkih vcs https://github.com/City-of-Helsinki/headless-cms-theme && \
    composer require devgeniem/hkih-theme:$WP_THEME_VERSION_HEADLESS && \
    composer config repositories.advanced-custom-fields-pro vcs https://github.com/City-of-Helsinki/wordpress-helfi-plugin-advanced-custom-fields-pro && \
    composer require acf/advanced-custom-fields-pro && \
    composer config repositories.filebird-pro vcs https://github.com/City-of-Helsinki/wordpress-helfi-plugin-filebird-pro && \
    composer require ninjateam/filebird-pro:$WP_PLUGIN_VERSION_FILEBIRD_PRO && \
    composer config repositories.polylang-pro vcs https://github.com/City-of-Helsinki/wordpress-helfi-plugin-polylang-pro && \
    composer require wpsyntex/polylang-pro && \
    composer config repositories.wpo365-login-premium vcs https://github.com/City-of-Helsinki/wordpress-helfi-plugin-wpo365-login-premium && \
    composer require wpo365/wpo365-login-premium && \
    composer config repositories.publishpress-revisions-pro vcs https://github.com/City-of-Helsinki/wordpress-helfi-plugin-publishpress-revisions-pro && \
    composer require publishpress/publishpress-revisions-pro && \
    composer config repositories.wp-all-import-pro vcs https://github.com/City-of-Helsinki/wordpress-helfi-plugin-wp-all-import-pro && \
    composer require soflyy/wp-all-import-pro && \
    composer config repositories.wp-all-import-pro vcs https://github.com/City-of-Helsinki/wordpress-helfi-plugin-activity-log && \
    composer require city-of-helsinki/activity-log && \
    composer config repositories.packagist composer https://packagist.org && \
    composer require devgeniem/hkih-linkedevents:$WP_PLUGIN_VERSION_HKIH_LINKEDEVENTS && \
    composer require devgeniem/hkih-cpt-collection:$WP_PLUGIN_VERSION_HKIH_CPT_COLLECTION && \
    composer require devgeniem/hkih-cpt-contact:$WP_PLUGIN_VERSION_HKIH_CPT_CONTACT && \
    composer require devgeniem/hkih-cpt-landing-page:$WP_PLUGIN_VERSION_HKIH_CPT_LANDING_PAGE && \
    composer require devgeniem/hkih-cpt-release:$WP_PLUGIN_VERSION_HKIH_CPT_RELEASE && \
    composer require devgeniem/hkih-cpt-translation:$WP_PLUGIN_VERSION_HKIH_CPT_TRANSLATION && \
    composer require devgeniem/hkih-sportslocations:$WP_PLUGIN_VERSION_HKIH_CPT_SPORTSLOCATIONS && \
    composer require valu/wp-graphql-cache:$WP_PLUGIN_VERSION_WP_GRAPHQL_CACHE && \
    composer require valu/wp-graphql-polylang:$WP_PLUGIN_VERSION_WP_GRAPHQL_POLYLANG && \
    composer require wp-graphql/wp-graphql-jwt-authentication:$WP_PLUGIN_VERSION_WP_GRAPHQL_JWT_AUTHENTICATION && \
    composer require devgeniem/acf-codifier:$WP_PLUGIN_VERSION_ACF_CODIFIER && \
    composer require xwp/stream:$WP_PLUGIN_VERSION_STREAM && \
    composer require devgeniem/wp-define-more:$WP_PLUGIN_VERSION_WP_DEFINE_MORE && \
    composer require "composer/installers:2.2 as v1.99.99" devgeniem/wp-geniem-project-bells-and-whistles:$WP_PLUGIN_WP_GENIEM_PROJECT_BELLS_AND_WHISTLES && \
    composer require devgeniem/wp-geniem-roles:$WP_PLUGIN_VERSION_WP_GENIEM_ROLES && \
    composer require wp-graphql/wp-graphql:$WP_PLUGIN_WP_GRAPHQL && \
    composer require rarst/wps:$WP_PLUGIN_VERSION_WPS && \
    composer require devgeniem/wp-sanitize-accented-uploads:$WP_PLUGIN_VERSION_WP_SANITIZE_ACCENTED_UPLOADS && \
    composer config repositories.wpackagist composer https://wpackagist.org && \
    composer require wpackagist-plugin/autodescription:$WP_PLUGIN_VERSION_AUTODESCRIPTION && \
    composer require wpackagist-plugin/duplicate-post:$WP_PLUGIN_VERSION_DUPLICATE_POST && \
    composer require wpackagist-plugin/query-monitor:$WP_PLUGIN_VERSION_QUERY_MONITOR && \
    composer require wpackagist-plugin/regenerate-thumbnails:$WP_PLUGIN_VERSION_REGENERATE_THUMBNAILS && \
    composer require wpackagist-plugin/redis-cache:$WP_PLUGIN_VERSION_REDIS_CACHE && \
    composer require wpackagist-plugin/svg-support:$WP_PLUGIN_VERSION_SVG_SUPPORT && \
    composer require wpackagist-plugin/wordpress-importer:$WP_PLUGIN_VERSION_WORDPRESS_IMPORTER && \
    composer require wpackagist-plugin/wp-sentry-integration:$WP_PLUGIN_VERSION_WP_SENTRY_INTEGRATION && \
    composer require wpackagist-plugin/wpo365-login:$WP_PLUGIN_VERSION_WPO365_LOGIN && \
    rm -f /opt/app-root/src/.config/composer/auth.json