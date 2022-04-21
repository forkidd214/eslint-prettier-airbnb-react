# Prerequisites

```bash
npx create-react-app my-app
```

# Installation

1. Navigate to your app directory where you want to include this style configuration.

   ```bash
   cd my-app
   ```

2. Run this command inside your app's root directory. Note: this command executes the `eslint-prettier-config.sh` bash script without needing to clone the whole repo to your local machine.

   ```bash
   exec 3<&1;bash <&3 <(curl https://raw.githubusercontent.com/forkidd214/eslint-prettier-airbnb-react/master/eslint-prettier-config.sh 2> /dev/null)
   ```

3. Make selections for your preference of package manager (npm or yarn), file format (.js or .json).

4. Look in your project's root directory and notice the two newly added/updated config files:

   - `.eslintrc.js` (or `.eslintrc.json`) _(optional)_
   - `.prettierrc.js` (or `.prettierrc.json`)

5. In your package.json file, manually update ESlint config as below:
   ```
   {...
     "eslintConfig": {
       "extends": [
         "react-app",
         "react-app/jest",
         "airbnb",
         "airbnb/hooks",
         "prettier"
       ]
     },
     ...}
   ```

# Packages

### Main Packages

1. ~~[ESlint](https://eslint.org/)~~ _(already included in CRA)_
2. [Prettier](https://prettier.io/)

### Airbnb Configuration

1. [eslint-config-airbnb](https://www.npmjs.com/package/eslint-config-airbnb)
   - This package provides Airbnb's .eslintrc as an extensible shared config.
2. ~~[eslint-plugin-react](https://github.com/yannickcr/eslint-plugin-react) (Peer Dependency)~~
   - ~~React specific linting rules for ESLint~~
3. ~~[eslint-plugin-import](https://www.npmjs.com/package/eslint-plugin-import) (Peer Dependency)~~
   - ~~Support linting of ES2015+ (ES6+) import/export syntax, and prevent issues with misspelling of file paths and import names.~~
4. ~~[eslint-plugin-jsx-a11y](https://github.com/evcohen/eslint-plugin-jsx-a11y) (Peer Dependency)~~
   - ~~Static AST checker for accessibility rules on JSX elements.~~
5. ~~[babel-eslint](https://github.com/babel/babel-eslint)~~
   - ~~A wrapper for Babel's parser used for ESLint.~~
   - ~~We decided to include this since [Airbnb Style Guide uses Babel](https://github.com/airbnb/javascript#airbnb-javascript-style-guide-).~~

- _(babel-eslint is now [@babel/eslint-parser](https://www.npmjs.com/package/@babel/eslint-parser) and has moved into the Babel monorepo.)_
- _(And all these strikethrough packages were already included in CRA=>react-scripts=>eslint-config-react-app_)

### ESlint, Prettier Integration

1. ~~[eslint-plugin-prettier](https://github.com/prettier/eslint-plugin-prettier)~~ _(not recommended by Prettier's [Integrating with Linters](https://prettier.io/docs/en/integrating-with-linters.html))_
   - ~~Runs Prettier as an ESLint rule and reports differences as individual ESLint issues.~~
2. [eslint-config-prettier](https://github.com/prettier/eslint-config-prettier)
   - Turns off all rules that are unnecessary or might conflict with Prettier.

# Created Configuration Files

Once files are created, you may edit to your liking.

### in `package.json` (dafault)

```
{
   ....
  "eslintConfig": {
    "extends": [
      "react-app",
      "react-app/jest",
      "airbnb",
      "airbnb/hooks",
      "prettier"
    ]
  },
  ....
}
```

### or eslintrc(.js/.json) if existing

- [more info](https://eslint.org/docs/user-guide/configuring)

```
{
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
}
```

### prettierrc(.js/.json)

- [more Info](https://prettier.io/docs/en/configuration.html)

```
{
  "trailingComma": "es5",
  "tabWidth": 2,
  "semi": false,
  "singleQuote": true,
  "printWidth": 80,
  "endOfLine": "auto"
}
```

---

This script is a custom version of [paulolramos/eslint-prettier-airbnb-react](https://github.com/paulolramos/eslint-prettier-airbnb-react)
