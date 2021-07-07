process.env.NODE_ENV = process.env.NODE_ENV || 'development';

const environment = require('./environment');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const ESLintPlugin = require('eslint-webpack-plugin');
const path = require('path');

environment.plugins.append(
    'CleanWebpackPlugin',
    new CleanWebpackPlugin({
        verbose: true,
        cleanOnceBeforeBuildPatterns: [path.join(process.cwd(), 'public/packs/**/*')]
    }),
    'ESLintPlugin',
    new ESLintPlugin({
        overrideConfigFile: '.eslintrc',
        context: 'app/webpacker',
        files: '**/*.js',
    })
);

module.exports = environment.toWebpackConfig();
