const path = require('path');
const TerserPlugin = require('terser-webpack-plugin');

module.exports = {
	watch: true,
	mode: 'production',
	entry: './src/memory.ts',
	optimization: {
		minimize: true,
		minimizer: [new TerserPlugin()],
	},
	module: {
		rules: [
			{
				test: /\.tsx?$/,
				use: 'ts-loader',
				exclude: /node_modules/,
			},
		],
	},
	resolve: {
		extensions: ['.tsx', '.ts', '.js'],
	},
	output: {
		filename: 'memory.js',
		path: path.resolve(__dirname, 'dist'),
	},
};
