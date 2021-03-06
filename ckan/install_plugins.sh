#!/bin/bash
####
# Script to install ckanext-doi
# https://github.com/NaturalHistoryMuseum/ckanext-doi
#
# Set environment variables in ckan/contrib/docker/.env
#####

if [ $DOI_EXT_PLUGIN -eq 1 ] && [ ! -d "$CKAN_VENV/src/ckanext-doi" ]
then
    ## Download and install ckanext-doi
    cd $CKAN_VENV/src && \
        git clone https://github.com/NaturalHistoryMuseum/ckanext-doi.git && \
        . $CKAN_VENV/bin/activate && \
        cd $CKAN_VENV/src/ckanext-doi && \
        pip install -r requirements.txt && \
        cd $CKAN_VENV/src/ckanext-doi && \
        python setup.py develop

    # Configuring production.ini
    sed -i '/ckan.plugins/s/$/ doi/' $CKAN_CONFIG/production.ini

    sed -i '/Front-End Settings/ i\## ckanext-doi Settings' $CKAN_CONFIG/production.ini
    sed -i '/Front-End Settings/ i\ckanext.doi.account_name = '$DOI_EXT_ACCOUNT_NAME'' $CKAN_CONFIG/production.ini
    sed -i '/Front-End Settings/ i\ckanext.doi.account_password = '$DOI_EXT_ACCOUNT_PASSWORD'' $CKAN_CONFIG/production.ini
    sed -i '/Front-End Settings/ i\ckanext.doi.prefix = '$DOI_EXT_PREFIX'' $CKAN_CONFIG/production.ini
    sed -i '/Front-End Settings/ i\ckanext.doi.publisher = '$DOI_EXT_PUBLISHER'' $CKAN_CONFIG/production.ini
    sed -i '/Front-End Settings/ i\ckanext.doi.test_mode = '$DOI_EXT_TEST_MODE'' $CKAN_CONFIG/production.ini
fi

####
# Script to install ckanext-doi
# https://github.com/NaturalHistoryMuseum/ckanext-userdatasets
#
#####
if [ $USERDATA_EXT_PLUGIN -eq 1 ] && [ ! -d "$CKAN_VENV/src/ckanext-userdatasets" ]
then

    ## Download and install ckanext-userdatasets
    cd $CKAN_VENV/src && \
        git clone https://github.com/NaturalHistoryMuseum/ckanext-userdatasets.git && \
        . $CKAN_VENV/bin/activate && \
        cd $CKAN_VENV/src/ckanext-userdatasets && \
        pip install -r requirements.txt && \
        cd $CKAN_VENV/src/ckanext-userdatasets && \
        python setup.py develop

    # Configuring production.ini
    sed -i '/ckan.plugins/s/$/ userdatasets/' $CKAN_CONFIG/production.ini
    sed -i '/Front-End Settings/ i\ckanext.userdatasets.default_auth_module = '$USERDATA_AUTH_MODULE'' $CKAN_CONFIG/production.ini
    sed -i '/Front-End Settings/ i\ckanext.userdatasets.default_action_module = '$USERDATA_ACTION_MODULE'' $CKAN_CONFIG/production.ini
 
fi
