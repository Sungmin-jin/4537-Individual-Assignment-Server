const {createPool} = require('mysql')

const pool = createPool({
    port: 3306,
    host:"us-cdbr-east-03.cleardb.com",
    user:"b546cec8ff3a45",
    password:"d66d8e9c",
    database : "heroku_bcf5e28610cc6b3",
})

let chirprdb = {};

chirprdb.all = () => {
    return new Promise((resolve, reject)=> {

    })
}

module.exports = chirprdb;