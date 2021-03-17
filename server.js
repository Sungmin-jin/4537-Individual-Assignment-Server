const express = require('express');
const app = express();
let port = process.env.PORT || 3000;
const mysql = require('mysql');
const cors = require('cors');
require('dotenv').config();
const escape = require('./escape');
// const env = require('./env');

app.use(express.json());
app.use(function (req, res, next) {
  res.header('Access-Control-Allow-Origin', '*');
  res.header(
    'Access-Control-Allow-Headers',
    'Origin, X-Requested-With, Content-Type, Accept'
  );
  next();
});
app.use(cors());

const db_config = {
  host: 'us-cdbr-east-03.cleardb.com',
  user: 'b546cec8ff3a45',
  password: 'd66d8e9c',
  database: 'heroku_bcf5e28610cc6b3',
};

let connection;

function handleDisconnect() {
  connection = mysql.createConnection(db_config);
  connection.connect(function (err) {
    if (err) {
      console.log('error when connecting to db:', err);
      setTimeout(handleDisconnect, 2000);
    } else {
      console.log('connected to database');
    }
  });
  connection.on('error', function (err) {
    console.log('db error', err);
    if (err.code === 'PROTOCOL_CONNECTION_LOST') {
      handleDisconnect();
    } else {
      throw err;
    }
  });
}

handleDisconnect();

app.get('/admin/quizzes', (req, res) => {
  const sql = 'SELECT * FROM QUIZ';
  try {
    connection.query(sql, (err, result) => {
      if (err) {
        res.send(err);
        throw err;
      }
      res.json(result);
      return;
    });
  } catch (error) {
    console.log(error);
  }
});

app.get('/admin/quizzes/questions/:id', (req, res) => {
  const sql = `SELECT question.*, heroku_bcf5e28610cc6b3.\`option\`.* FROM question, heroku_bcf5e28610cc6b3.\`option\` WHERE Question.quizId = ${req.params.id} AND heroku_bcf5e28610cc6b3.\`option\`.questionId = question.questionId ORDER BY heroku_bcf5e28610cc6b3.\`option\`.questionId`;
  try {
    connection.query(sql, (err, result) => {
      if (err) {
        throw err;
      }
      // console.log(result);
      res.json(result);
    });
  } catch (error) {
    console.log(error);
  }
});

app.get('/student/quizzes', (req, res) => {
  const sql = 'SELECT * FROM QUIZ';
  try {
    connection.query(sql, (err, result) => {
      if (err) {
        res.send(err);
        throw err;
      }
      res.json(result);
      return;
    });
  } catch (error) {
    console.log(error);
  }
});

app.get('/student/quizzes/questions/:id', (req, res) => {
  const sql = `SELECT question.*, heroku_bcf5e28610cc6b3.\`option\`.* FROM question, heroku_bcf5e28610cc6b3.\`option\` WHERE Question.quizId = ${req.params.id} AND heroku_bcf5e28610cc6b3.\`option\`.questionId = question.questionId ORDER BY heroku_bcf5e28610cc6b3.\`option\`.questionId`;
  try {
    connection.query(sql, (err, result) => {
      if (err) {
        res.send(err);
        throw err;
      }
      res.json(result);
    });
  } catch (error) {
    console.log(error);
  }
});

app.post('/admin/quizzes', (req, res) => {
  const sql = `INSERT INTO quiz (quizName) VALUES ("${escape(
    req.body.quizName
  )}")`;
  try {
    connection.query(sql, (err, result) => {
      if (err) {
        res.json(err);
        throw err;
      }
      res.json(result);
    });
  } catch (error) {
    console.log(error);
  }
});

app.post('/admin/questions', (req, res) => {
  const sql = `INSERT INTO question (content, quizId) VALUES ("${escape(
    req.body.content
  )}", ${req.body.quizId})`;
  let response;
  try {
    connection.query(sql, async (err, result) => {
      if (err) {
        console.log(err);
        res.json({ status: false });
        throw err;
      }
      response = JSON.stringify(result);
      for (let option of req.body.options) {
        const newQuery = `INSERT INTO heroku_bcf5e28610cc6b3.\`option\` (detail, questionId, isAnswer) VALUES('${escape(
          option.detail
        )}', ${result.insertId}, ${option.isAnswer ? 'TRUE' : 'FALSE'});`;
        connection.query(newQuery, (error, result2) => {
          if (error) {
            console.log(error);
            res.json({ status: false });
            throw error;
          }

          response += JSON.stringify(result2);
        });
      }
      res.json({ status: true });
    });
  } catch (error) {
    console.log(error);
  }
});

app.put('/admin/questions', (req, res) => {
  try {
    if (req.body.content) {
      const sql = `UPDATE QUESTION SET content = '${escape(
        req.body.content
      )}' WHERE questionId = ${req.body.questionId}`;
      connection.query(sql, (err, result) => {
        if (err) {
          res.json(err);
          throw err;
        }
      });
    }
    console.log(req.body.options);
    for (let option of req.body.options) {
      // let checksql = 'SELECT FROM '

      let newSql;
      if (option.id == null) {
        newSql = `INSERT INTO heroku_bcf5e28610cc6b3.\`option\` (detail, questionId, isAnswer) VALUES('${escape(
          option.detail
        )}', ${req.body.questionId}, ${option.isAnswer ? 'TRUE' : 'FALSE'});`;
      } else if (option.detail === '') {
        newSql = `DELETE FROM heroku_bcf5e28610cc6b3.\`option\` WHERE optionId = ${option.id}`;
      } else {
        newSql = `UPDATE heroku_bcf5e28610cc6b3.\`option\` SET detail = '${escape(
          option.detail
        )}', isAnswer =${option.isAnswer ? 'TRUE' : 'FALSE'} WHERE optionId = ${
          option.id
        }`;
      }
      connection.query(newSql, (err, result) => {
        if (err) {
          console.log(err);
          res.json(err);
          throw err;
        }
        // console.log(result);
      });
    }
    res.json({ status: true });
  } catch (error) {
    console.log(error);
  }
});

app.get('/deleteQuiz', (req, res) => {
  const sql = 'delete FROM quiz;';
  try {
    connection.query(sql, (err, result) => {
      if (err) {
        res.send(err);
        throw err;
      }
      res.send(result);
    });
  } catch (error) {
    console.log(error);
  }
});

app.get('/deleteQuestion', (req, res) => {
  const sql = 'delete FROM question;';
  try {
    connection.query(sql, (err, result) => {
      if (err) {
        res.send(err);
        throw err;
      }
      res.send(result);
    });
  } catch (error) {
    console.log(error);
  }
});

app.get('/deleteOption', (req, res) => {
  const sql = 'delete FROM heroku_bcf5e28610cc6b3.`option`;';
  try {
    connection.query(sql, (err, result) => {
      if (err) {
        res.send(err);
        throw err;
      }
      res.send(result);
    });
  } catch (error) {
    console.log(error);
  }
});

app.listen(port, () => {
  console.log(env);
  console.log(`server running at ${port}`);
});
