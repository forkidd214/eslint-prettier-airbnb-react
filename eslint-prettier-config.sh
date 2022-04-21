#!/bin/bash

# ----------------------
# Color Variables
# ----------------------
RED="\033[0;31m"
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color

# --------------------------------------
# Prompts for configuration preferences
# --------------------------------------

# Package Manager Prompt
echo
echo "Which package manager are you using?"
select package_command_choices in "Yarn" "npm" "Cancel"; do
  case $package_command_choices in
    Yarn ) pkg_cmd='yarn add'; break;;
    npm ) pkg_cmd='npm install'; break;;
    Cancel ) exit;;
  esac
done
echo

# File Format Prompt
echo "Which ESLint and Prettier configuration format do you prefer?"
select config_extension in ".js" ".json" "Cancel"; do
  case $config_extension in
    .js ) config_opening='module.exports = {'; break;;
    .json ) config_opening='{'; break;;
    Cancel ) exit;;
  esac
done
echo

# Checks for existing eslintrc files
if [ -f ".eslintrc.js" -o -f ".eslintrc.yaml" -o -f ".eslintrc.yml" -o -f ".eslintrc.json" -o -f ".eslintrc" ]; then
  echo -e "${RED}Existing ESLint config file(s) found:${NC}"
  ls -a .eslint* | xargs -n 1 basename
  echo
  echo -e "${RED}CAUTION:${NC} there is loading priority when more than one config file is present: https://eslint.org/docs/user-guide/configuring#configuration-file-formats"
  echo
  read -p  "Write .eslintrc${config_extension} (Y/n)? "
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo -e "${YELLOW}>>>>> Skipping ESLint config${NC}"
    skip_eslint_setup="true"
  fi
else 
  echo
  echo -e "${YELLOW}>>>>> Assuming existing ESLint config come with CRA${NC}"
  echo -e "${YELLOW}>>>>> Check \"eslintConfig\" in package.json file${NC}"
  eslint_setup_in_package_json="true"
  echo
fi
# finished=false


# Checks for existing prettierrc files
if [ -f ".prettierrc.js" -o -f "prettier.config.js" -o -f ".prettierrc.yaml" -o -f ".prettierrc.yml" -o -f ".prettierrc.json" -o -f ".prettierrc.toml" -o -f ".prettierrc" ]; then
  echo -e "${RED}Existing Prettier config file(s) found${NC}"
  ls -a | grep "prettier*" | xargs -n 1 basename
  echo
  echo -e "${RED}CAUTION:${NC} The configuration file will be resolved starting from the location of the file being formatted, and searching up the file tree until a config file is (or isn't) found. https://prettier.io/docs/en/configuration.html"
  echo
  read -p  "Write .prettierrc${config_extension} (Y/n)? "
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo -e "${YELLOW}>>>>> Skipping Prettier config${NC}"
    skip_prettier_setup="true"
  fi
  echo
fi

# ----------------------
# Perform Configuration
# ----------------------
echo
echo -e "${GREEN}Configuring your development environment... ${NC}"

echo
echo -e "1/4 ${YELLOW}Conforming to Airbnb's JavaScript Style Guide... ${NC}"
echo
$pkg_cmd -D eslint-config-airbnb


echo
echo -e "2/4 ${LCYAN}Making ESlint and Prettier play nice with each other... ${NC}"
echo "See https://github.com/prettier/eslint-config-prettier for more details."
echo
$pkg_cmd -D prettier eslint-config-prettier




if [ "$eslint_setup_in_package_json" == "true" ]; then
  echo
  echo -e "3/4 ${RED}Please Manully Update package.json file as below... ${NC}"
  echo "\"eslintConfig\": {"
  echo "  \"extends\": ["
  echo "    \"react-app\","
  echo "    \"react-app/jest\","
  echo "    \"airbnb\","
  echo "    \"airbnb/hooks\","
  echo "    \"prettier\""
  echo "  ]"
  echo "},"
  echo
  break
else
  if [ "$skip_eslint_setup" == "true" ]; then
    break
  else
    echo
    echo -e "3/4 ${YELLOW}Building your .eslintrc${config_extension} file...${NC}"
    > ".eslintrc${config_extension}" # truncates existing file (or creates empty)

    echo ${config_opening}'
    "env": {
      "browser": true,
      "es2021": true
    },
    "extends": ["plugin:react/recommended", "airbnb", "airbnb/hooks", "prettier"],
    "parserOptions": {
      "ecmaFeatures": {
        "jsx": true
      },
      "ecmaVersion": "latest",
      "sourceType": "module"
    },
    "plugins": ["react"],
    "rules": {
      "linebreak-style": 0
    }
  }' >> .eslintrc${config_extension}
  fi
  break
fi





if [ "$skip_prettier_setup" == "true" ]; then
  break
else
  echo -e "4/4 ${YELLOW}Building your .prettierrc${config_extension} file... ${NC}"
  > .prettierrc${config_extension} # truncates existing file (or creates empty)

  echo ${config_opening}'
  "trailingComma": "es5",
  "tabWidth": 2,
  "semi": true,
  "singleQuote": true,
  "printWidth": 80,
  "endOfLine": "auto"
}' >> .prettierrc${config_extension}
fi

echo
echo -e "${GREEN}Finished setting up!${NC}"
echo
