CREATE TABLE heroku_bcf5e28610cc6b3.quiz (
	quizId INT auto_increment NOT NULL,
	quizName varchar(100) NOT NULL,
	CONSTRAINT quiz_pk PRIMARY KEY (quizId)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

CREATE TABLE heroku_bcf5e28610cc6b3.question (
	questionId INT auto_increment NOT NULL,
	content varchar(255) NOT NULL,
	quizId INT NOT NULL,
	CONSTRAINT question_pk PRIMARY KEY (questionId),
	CONSTRAINT question_FK FOREIGN KEY (quizId) REFERENCES heroku_bcf5e28610cc6b3.quiz(quizId)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;


CREATE TABLE heroku_bcf5e28610cc6b3.option (
	optionId INT auto_increment NOT NULL,
	detail varchar(255) NOT NULL,
	questionId INT NOT NULL,
	isAnswer BOOL NOT NULL,
	CONSTRAINT option_pk PRIMARY KEY (optionId),
	CONSTRAINT option_FK FOREIGN KEY (questionId) REFERENCES heroku_bcf5e28610cc6b3.question(questionId)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;