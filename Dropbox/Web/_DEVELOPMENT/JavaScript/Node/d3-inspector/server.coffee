connect = require 'connect'
express = require 'express'
path = require 'path'
bodyParser = require 'body-parser'
routes = require './app/routes'
mongoose = require 'mongoose'
app = express()

# set vars
ipaddress = process.env.OPENSHIFT_NODEJS_IP || '127.0.0.1'
port = process.env.OPENSHIFT_NODEJS_PORT || 8080

if process.env.OPENSHIFT_MONGODB_DB_PASSWORD then connection_string = "#{process.env.OPENSHIFT_MONGODB_DB_USERNAME}:#{process.env.OPENSHIFT_MONGODB_DB_PASSWORD}@#{process.env.OPENSHIFT_MONGODB_DB_HOST}:#{process.env.OPENSHIFT_MONGODB_DB_PORT}/#{process.env.OPENSHIFT_APP_NAME}";
else connection_string = 'localhost/d3'

app.use(bodyParser())

# set static dir
app.use('/', express.static(path.join(__dirname, 'public')))

# set the views folder and view engine
app.set('views', __dirname + '/app/views')
app.set('view engine', 'hbs')

# connect to DB
mongoose.connect("mongodb://#{connection_string}")
mongoose.connection.on('open', ->
  console.log('Connected to MongoDB...')
)

# routes list
router = express.Router()
routes(app, router)
app.use('/', router)

# boot the server
app.listen(port, ipaddress, ->
  console.log('Server up')
)