process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

console.log(environment.output_path)
console.log(environment.source_path)

module.exports = environment.toWebpackConfig()
