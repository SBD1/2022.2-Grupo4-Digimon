const { Client } = require('pg');
require('dotenv').config();

const client = new Client({
    user: process.env.PG_USER,
    host: process.env.PG_HOSTNAME,
    database: process.env.PG_DATABASE,
    password: process.env.PG_PASSWORD,
    port: process.env.PG_PORT,
    ssl: true
})

client.connect();

module.exports = client;